class CreateUserInformations < ActiveRecord::Migration
  def change
    create_table :user_informations do |t|
      t.references :user, index: true
      t.text :why
      t.text :past
      t.text :projects
      t.text :places
      t.text :mentoring
      t.timestamps
    end
  end
end
