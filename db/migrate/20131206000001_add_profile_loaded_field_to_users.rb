class AddProfileLoadedFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_loaded, :boolean
  end
end
