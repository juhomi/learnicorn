class CreateAssignmentAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :assignment_answers do |t|
      t.references :assignment_submission, null: false, foreign_key: true
      t.references :assignment_question, null: false, foreign_key: true
      t.text :answer_text
      t.boolean :is_correct, default: false
      t.integer :points_earned, default: 0

      t.timestamps
    end

    add_index :assignment_answers, [ :assignment_submission_id, :assignment_question_id ],
              unique: true, name: 'index_assignment_answers_on_submission_and_question'
    add_index :assignment_answers, :is_correct
  end
end
