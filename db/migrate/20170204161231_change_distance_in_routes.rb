class ChangeDistanceInRoutes < ActiveRecord::Migration[5.0]
  def change
    change_column :routes, :distance, :decimal, precision: 10, scale: 2, null: false
  end
end
