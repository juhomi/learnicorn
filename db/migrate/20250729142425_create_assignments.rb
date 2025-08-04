class CreateAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :assignments do |t|
      t.string :title, null: false, limit: 200
      t.text :description
      t.references :lesson, null: false, foreign_key: true
      t.integer :assignment_type, default: 0, null: false
      t.integer :max_score, default: 100
      t.datetime :due_date
      t.text :instructions
      t.integer :position, null: false, default: 1
      t.boolean :published, default: false, null: false

      t.timestamps
    end

    add_index :assignments, [ :lesson_id, :position ]
    add_index :assignments, :published
    add_index :assignments, :due_date
  end
end
