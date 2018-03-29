class ChangeStatusAndRolesInUsers < ActiveRecord::Migration[5.1]
  def change
  	change_column :users, :roles, :integer
  	change_column :users, :status, :integer
  	rename_column :users, :roles, :role
  end
end
