class CreateAssignmentQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :assignment_questions do |t|
      t.references :assignment, null: false, foreign_key: true
      t.text :question_text, null: false
      t.integer :question_type, default: 0, null: false
      t.integer :points, default: 10, null: false
      t.integer :position, null: false
      t.json :options, default: {}
      t.text :correct_answer
      t.text :explanation

      t.timestamps
    end

    add_index :assignment_questions, [ :assignment_id, :position ]
    add_index :assignment_questions, :question_type
  end
end
