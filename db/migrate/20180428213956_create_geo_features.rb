class CreateGeoFeatures < ActiveRecord::Migration[5.0]
  def change
    create_table :geo_features do |t|
      t.integer 	:feature_id
      t.string 		:feature_name
      t.string 		:feature_class
      t.string   	:state
      t.string   	:county
      t.string   	:lat_degrees
      t.string   	:long_degrees
      t.decimal  	:lat_decimal
      t.decimal  	:long_decimal
      t.integer  	:elev_in_meters
      t.integer  	:elevation
      t.string   	:map_name

      t.timestamps
    end
  end
end
