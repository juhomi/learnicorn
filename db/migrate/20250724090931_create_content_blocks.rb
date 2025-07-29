class CreateContentBlocks < ActiveRecord::Migration[8.0]
  def change
    create_table :content_blocks do |t|
      t.references :lesson, null: false, foreign_key: true
      t.integer :block_type, null: false
      t.integer :position, null: false
      t.text :content
      t.string :file_url
      t.string :alt_text
      t.json :metadata, default: {}

      t.timestamps
    end
    
    add_index :content_blocks, [:lesson_id, :position]
    add_index :content_blocks, :block_type
  end
end
