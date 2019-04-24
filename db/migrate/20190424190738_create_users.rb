class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.string :image
      t.string :image_url
      t.references :gender, foreign_key: true
      t.string :coordinates
      t.date :date_of_birth
      t.string :password_digest
      t.timestamps
    end
  end
end
