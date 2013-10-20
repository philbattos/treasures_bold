class ChangeDataTypeForCoordinates < ActiveRecord::Migration
  def change
  	change_column :landings, :lat_decimal, :decimal
  	change_column :landings, :long_decimal, :decimal 
  end
end
