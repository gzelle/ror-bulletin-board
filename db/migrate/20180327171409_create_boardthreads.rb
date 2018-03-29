class CreateBoardthreads < ActiveRecord::Migration[5.1]
  def change
    create_table :boardthreads do |t|
      t.string :title

      t.timestamps
    end
  end
end
