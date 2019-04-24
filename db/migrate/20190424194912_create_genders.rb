class CreateGenders < ActiveRecord::Migration[5.2]
  def change
    create_table :genders do |t|
      t.name
      t.timestamps
    end
  end
end

# rake db:migrate:up VERSION=20190424194912
