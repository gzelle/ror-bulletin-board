class AddReferences < ActiveRecord::Migration[5.1]
  def change
  	add_reference :boards, :topic, index: true
  	add_reference :boardthreads, :board, index: true
  	add_reference :boardthreads, :user, index: true
  	add_reference :posts, :boardthread, index: true
  	add_reference :posts, :user, index: true
  end
end
