require 'csv'

Landing.delete_all
Landing.tire.index.delete

def inside_east_west_boundary(long_coordinate) # boundaries
  long_coordinate.abs.between?(102, 116)
end

def inside_north_south_boundary(lat_coordinate) # boundaries
  lat_coordinate.between?(35.5, 49)
end

def searchable_states
  %w{ CO MT NM WY }
end

def add_new_landings(row)
  Landing.create! feature_id: row[:feature_id],
                  feature_name: row[:feature_name],
                  feature_class: row[:feature_class],
                  state: row[:state_alpha],
                  county: row[:county_name],
                  lat_degrees: row[:primary_lat_dms],
                  long_degrees: row[:prim_long_dms],
                  lat_decimal: row[:prim_lat_dec],
                  long_decimal: row[:prim_long_dec],
                  elev_in_meters: row[:elev_in_m],
                  elevation: row[:elev_in_ft],
                  map_name: row[:map_name]
  # Landing.reindex
end

seed_files = ['db/seed_data_files/CO_Features_20130404.txt',
              'db/seed_data_files/MT_Features_20130404.txt',
              'db/seed_data_files/NM_Features_20130404.txt',
              'db/seed_data_files/WY_Features_20130404.txt' ]

# seed_files.each do |file|
#   CSV.table(file, col_sep: '|').each do |row|
#     if inside_east_west_boundary(row[:prim_long_dec])
#       if inside_north_south_boundary(row[:prim_lat_dec])
#         if searchable_states.include?(row[:state_alpha].upcase)
    
#           add_new_landings(row)

#         end
#       end
#     end
#   end
# end

# Santa Fe and north = 35.5+
# Canada/Montana border = 49.0
# Colorado eastern border = -102
# Montana western border = -116

### small sample file for testing
CSV.table('db/seed_samples/CO_Features_Small_20130404.txt', col_sep: '|').each do |row|

  if inside_east_west_boundary(row[:prim_long_dec])
    if inside_north_south_boundary(row[:prim_lat_dec])
      if searchable_states.include?(row[:state_alpha].upcase)
  
        add_new_landings(row)
        # Landing.reindex

      end
    end
  end

end


### Rails templating
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

