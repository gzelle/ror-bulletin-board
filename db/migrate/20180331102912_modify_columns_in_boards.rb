class ModifyColumnsInBoards < ActiveRecord::Migration[5.1]
  def change
  	add_column :boards, :description, :string
	remove_column :boards, :post_count, :integer
  end
end
