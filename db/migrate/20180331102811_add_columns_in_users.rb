class AddColumnsInUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :post_count, :integer
	add_column :users, :skype, :text
	add_column :users, :website, :text
	add_column :users, :gender, :integer
	add_column :users, :interests, :text
  end
end
