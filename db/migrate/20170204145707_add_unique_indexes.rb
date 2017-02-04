class AddUniqueIndexes < ActiveRecord::Migration[5.0]
  def change
    add_index :addresses, [:address], unique: true, name: 'isx_unique_address'
    add_index :routes, [:start_address_id, :destination_address_id], unique: true, name: 'idx_ruoute_unique'
  end
end
