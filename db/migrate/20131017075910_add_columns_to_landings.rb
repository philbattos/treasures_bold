class AddColumnsToLandings < ActiveRecord::Migration
  def change
  	add_column :landings, :state, :string
  	add_column :landings, :county, :string
  	add_column :landings, :lat_degrees, :string
  	add_column :landings, :long_degrees, :string
  	add_column :landings, :lat_decimal, :integer
  	add_column :landings, :long_decimal, :integer
  	add_column :landings, :elev_in_meters, :integer
  	add_column :landings, :elevation, :integer
  	add_column :landings, :map_name, :string
  end
end
