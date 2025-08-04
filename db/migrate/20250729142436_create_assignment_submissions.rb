class CreateAssignmentSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :assignment_submissions do |t|
      t.references :assignment, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :submitted_at
      t.integer :score, default: 0
      t.integer :max_score
      t.integer :status, default: 0, null: false
      t.text :feedback
      t.boolean :auto_graded, default: false
      t.datetime :graded_at

      t.timestamps
    end

    add_index :assignment_submissions, [ :assignment_id, :user_id ], unique: true
    add_index :assignment_submissions, :status
    add_index :assignment_submissions, :submitted_at
  end
end
