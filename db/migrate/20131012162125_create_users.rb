class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :city
      t.string :email
      t.string :image_url
      t.string :job

      t.timestamps
    end
  end
end
