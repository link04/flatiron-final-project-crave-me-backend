class CreateMatchedCraves < ActiveRecord::Migration[5.2]
  def change
    create_table :matched_craves do |t|
      t.belongs_to :crave, foreign_key: true
      t.belongs_to :match, foreign_key: true
      t.boolean :accepted_match

      t.timestamps
    end
  end
end
