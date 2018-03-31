class RenameColumnInBoardthreads < ActiveRecord::Migration[5.1]
  def change
  	rename_column :boardthreads, :type, :threadtype
  end
end
