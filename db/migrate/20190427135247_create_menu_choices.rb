class CreateMenuChoices < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_choices do |t|
      t.string :name
      t.string :category

      t.timestamps
    end
  end
end
