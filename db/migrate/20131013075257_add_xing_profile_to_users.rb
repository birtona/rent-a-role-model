class AddXingProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :xing_profile, :string
  end
end
