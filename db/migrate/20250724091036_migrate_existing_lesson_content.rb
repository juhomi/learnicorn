class MigrateExistingLessonContent < ActiveRecord::Migration[8.0]
  def up
    say "Migrating existing lesson content to content blocks..."

    Lesson.find_each do |lesson|
      position = 1

      # Migrate existing text content
      if lesson.content.present?
        lesson.content_blocks.create!(
          block_type: 'text',
          content: lesson.content,
          position: position
        )
        position += 1
        say "Migrated text content for lesson '#{lesson.title}'"
      end

      # Migrate existing video
      if lesson.video_url.present?
        lesson.content_blocks.create!(
          block_type: 'video',
          file_url: lesson.video_url,
          position: position
        )
        say "Migrated video content for lesson '#{lesson.title}'"
      end
    end

    say "Migration completed successfully!"
  end

  def down
    say "Reverting content blocks migration..."

    Lesson.find_each do |lesson|
      # Restore text content from first text block
      text_block = lesson.content_blocks.text.ordered.first
      if text_block
        lesson.update!(content: text_block.content)
      end

      # Restore video URL from first video block
      video_block = lesson.content_blocks.video.ordered.first
      if video_block
        lesson.update!(video_url: video_block.file_url)
      end
    end

    # Remove all content blocks
    ContentBlock.delete_all

    say "Rollback completed successfully!"
  end
end
