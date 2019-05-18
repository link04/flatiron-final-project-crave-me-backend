class CreateCraves < ActiveRecord::Migration[5.2]
  def change
    create_table :craves do |t|
      t.belongs_to :user, foreign_key: true
      t.integer :main_course_id
      t.integer :dessert_id
      t.integer :drink_id
      t.string :other
      t.timestamps
    end
  end
end
