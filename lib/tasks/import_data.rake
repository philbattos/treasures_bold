require 'csv'

NEW_MEXICO_EAST_BOUNDARY  = -102.80
NEW_MEXICO_WEST_BOUNDARY  = -109.20
NEW_MEXICO_SOUTH_BOUNDARY =   31.33 # this is the southern boundary of NM, not the boundary of Santa Fe
NEW_MEXICO_NORTH_BOUNDARY =   37.20
COLORADO_EAST_BOUNDARY    = -101.80
COLORADO_WEST_BOUNDARY    = NEW_MEXICO_WEST_BOUNDARY
COLORADO_NORTH_BOUNDARY   =   41.20
COLORADO_SOUTH_BOUNDARY   =   36.80
WYOMING_EAST_BOUNDARY     = -103.80
WYOMING_WEST_BOUNDARY     = -111.20
WYOMING_NORTH_BOUNDARY    =   45.20
WYOMING_SOUTH_BOUNDARY    =   40.80
MONTANA_EAST_BOUNDARY     = WYOMING_EAST_BOUNDARY
MONTANA_WEST_BOUNDARY     = -116.20
MONTANA_NORTH_BOUNDARY    =   49.20
MONTANA_SOUTH_BOUNDARY    =   44.80

SEARCH_AREA_EAST_BOUNDARY  = COLORADO_EAST_BOUNDARY
SEARCH_AREA_WEST_BOUNDARY  = MONTANA_WEST_BOUNDARY
SEARCH_AREA_NORTH_BOUNDARY = MONTANA_NORTH_BOUNDARY
SEARCH_AREA_SOUTH_BOUNDARY = NEW_MEXICO_SOUTH_BOUNDARY

namespace :import_data do
  desc "Import seed-data files for all states"
  task :all_states => :environment do
    # TO DO: wipe database with pg-dump or something. we could use GeoFeature.delete_all but that probably won't reset the IDs
    longitude_errors  = []
    latitude_errors   = []
    invalid_states    = []
    imported_features = 0

    Dir.glob('db/seed_data_files/*.txt') do |file|
      puts "Loading seed file #{file}"

      CSV.table(file, col_sep: '|').each do |row|
        if outside_longitude_range?(row[:prim_long_dec], SEARCH_AREA_EAST_BOUNDARY, SEARCH_AREA_WEST_BOUNDARY)
          puts "FAILED LONGITUDE ROW: #{row.inspect}\n\n"
          longitude_errors << row
          next
        end

        if outside_latitude_range?(row[:prim_lat_dec], SEARCH_AREA_SOUTH_BOUNDARY, SEARCH_AREA_NORTH_BOUNDARY)
          puts "FAILED LATITUDE ROW: #{row.inspect}\n\n"
          latitude_errors << row
          next
        end

        if !search_area_states?(row[:state_alpha].upcase)
          puts "FAILED STATE: #{row.inspect}\n\n"
          invalid_states << row
          next
        end

        imported_features += 1

        add_new_geo_feature(row)
      end
    end

    puts "All state data imported: #{imported_features} features."
    puts "There were #{longitude_errors.count} features that were outside the east-west boundary."
    puts "There were #{latitude_errors.count} features that were outside the north-south boundary."
    puts "There were #{invalid_states.count} features that were not in any of the search-area states."
  end

  desc "Import seed-data file for Colorado"
  task :colorado => :environment do
    longitude_errors  = []
    latitude_errors   = []
    invalid_states    = []
    imported_features = 0

    Dir.glob('db/seed_data_files/CO_Features_*.txt') do |file|
      puts "Loading seed file for Colorado: #{file}"

      CSV.table(file, col_sep: '|').each do |row|
        if outside_longitude_range?(row[:prim_long_dec], COLORADO_EAST_BOUNDARY, COLORADO_WEST_BOUNDARY)
          puts "FAILED LONGITUDE ROW: #{row.inspect}\n\n"
          longitude_errors << row
          next
        end

        if outside_latitude_range?(row[:prim_lat_dec], COLORADO_SOUTH_BOUNDARY, COLORADO_NORTH_BOUNDARY)
          puts "FAILED LATITUDE ROW: #{row.inspect}\n\n"
          latitude_errors << row
          next
        end

        if !colorado?(row[:state_alpha].upcase)
          puts "FAILED STATE: #{row.inspect}\n\n"
          invalid_states << row
          next
        end

        imported_features += 1

        add_new_geo_feature(row)
      end
    end

    puts "Colorado data imported: #{imported_features} features."
    puts "There were #{longitude_errors.count} features that were outside the east-west boundary."
    puts "There were #{latitude_errors.count} features that were outside the north-south boundary."
    puts "There were #{invalid_states.count} features that were not in Colorado."
  end

  desc "Import seed-data file for New Mexico"
  task :new_mexico => :environment do
    longitude_errors  = []
    latitude_errors   = []
    invalid_states    = []
    imported_features = 0

    Dir.glob('db/seed_data_files/NM_Features_*.txt') do |file|
      puts "Loading seed file for New Mexico: #{file}"

      CSV.table(file, col_sep: '|').each do |row|
        if outside_longitude_range?(row[:prim_long_dec], NEW_MEXICO_EAST_BOUNDARY, NEW_MEXICO_WEST_BOUNDARY)
          puts "FAILED LONGITUDE ROW: #{row.inspect}\n\n"
          longitude_errors << row
          next
        end

        if outside_latitude_range?(row[:prim_lat_dec], NEW_MEXICO_SOUTH_BOUNDARY, NEW_MEXICO_NORTH_BOUNDARY)
          puts "FAILED LATITUDE ROW: #{row.inspect}\n\n"
          latitude_errors << row
          next
        end

        if !new_mexico?(row[:state_alpha].upcase)
          puts "FAILED STATE: #{row.inspect}\n\n"
          invalid_states << row
          next
        end

        imported_features += 1

        add_new_geo_feature(row)
      end
    end

    puts "New Mexico data imported: #{imported_features} features."
    puts "There were #{longitude_errors.count} features that were outside the east-west boundary."
    puts "There were #{latitude_errors.count} features that were outside the north-south boundary."
    puts "There were #{invalid_states.count} features that were not in New Mexico."
  end

  def outside_longitude_range?(long_coordinate, east_boundary, west_boundary)
    !long_coordinate.abs.between?(east_boundary.abs, west_boundary.abs)
  end

  def outside_latitude_range?(lat_coordinate, south_boundary, north_boundary)
    !lat_coordinate.abs.between?(south_boundary, north_boundary)
  end

  def colorado?(state)
    state == 'CO'
  end

  def new_mexico?(state)
    state == 'NM'
  end

  def search_area_states?(state)
    %w( CO MT NM WY ).include?(state)
  end

  def add_new_geo_feature(csv_row)
    GeoFeature.create!(
        feature_id:     csv_row[:feature_id],
        feature_name:   csv_row[:feature_name],
        feature_class:  csv_row[:feature_class],
        state:          csv_row[:state_alpha],
        county:         csv_row[:county_name],
        lat_degrees:    csv_row[:primary_lat_dms],
        long_degrees:   csv_row[:prim_long_dms],
        lat_decimal:    csv_row[:prim_lat_dec],
        long_decimal:   csv_row[:prim_long_dec],
        elev_in_meters: csv_row[:elev_in_m],
        elevation:      csv_row[:elev_in_ft],
        map_name:       csv_row[:map_name]
    )
  end
end

