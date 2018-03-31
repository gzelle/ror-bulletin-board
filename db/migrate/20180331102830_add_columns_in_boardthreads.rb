class AddColumnsInBoardthreads < ActiveRecord::Migration[5.1]
  def change
  	add_column :boardthreads, :post_count, :integer
	add_column :boardthreads, :status, :integer
	add_column :boardthreads, :type, :integer
  end
end
