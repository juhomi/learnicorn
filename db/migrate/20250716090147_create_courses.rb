class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.integer :duration
      t.references :instructor, null: false, foreign_key: { to_table: :users }
      t.boolean :published, default: false

      t.timestamps
    end
  end
end
