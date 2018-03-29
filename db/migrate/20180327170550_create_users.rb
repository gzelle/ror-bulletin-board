class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :about
      t.date :birthdate
      t.string :hometown
      t.string :present_location
      t.string :roles
      t.string :status

      t.timestamps
    end
  end
end
