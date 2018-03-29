class CreateBoards < ActiveRecord::Migration[5.1]
  def change
    create_table :boards do |t|
      t.string :name
      t.integer :thread_count
      t.integer :post_count

      t.timestamps
    end
  end
end
