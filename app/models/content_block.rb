class ContentBlock < ApplicationRecord
  belongs_to :lesson

  validates :block_type, presence: true, inclusion: { in: %w[text image video] }
  validates :position, presence: true, numericality: { greater_than: 0 }
  validates :content, presence: true, if: -> { block_type == "text" }
  validates :file_url, presence: true, if: -> { block_type.in?([ "image", "video" ]) }
  validates :file_url, format: { with: URI.regexp(%w[http https]) }, allow_blank: true

  scope :ordered, -> { order(:position) }
  scope :by_type, ->(type) { where(block_type: type) }

  enum :block_type, { text: 0, image: 1, video: 2 }

  before_validation :set_default_position, on: :create

  def next_block
    lesson.content_blocks.where("position > ?", position).ordered.first
  end

  def previous_block
    lesson.content_blocks.where("position < ?", position).ordered.last
  end

  def move_to_position(new_position)
    return if position == new_position

    ContentBlock.transaction do
      if new_position > position
        lesson.content_blocks.where("position > ? AND position <= ?", position, new_position)
              .update_all("position = position - 1")
      else
        lesson.content_blocks.where("position >= ? AND position < ?", new_position, position)
              .update_all("position = position + 1")
      end

      update!(position: new_position)
    end
  end

  private

  def set_default_position
    return if position.present?

    max_position = lesson&.content_blocks&.maximum(:position) || 0
    self.position = max_position + 1
  end
end
