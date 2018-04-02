class AddPhotoToBoards < ActiveRecord::Migration[5.1]
  def change
  	add_column :boards, :photo, :string
  end
end
