class GeoFeature < ActiveRecord::Base

  # DEFAULT SETTINGS: north of Santa Fe, above 5000ft., below 10200ft., in 4 states

  DEFAULT_STATES         = %w[ CO MT NM WY ]
  DEFAULT_ELEVATION_LOW  = 5000
  DEFAULT_ELEVATION_HIGH = 10200
  ELEVATION_FLOOR        = 0
  ELEVATION_CEILING      = 14500
  DEFAULT_NORTH_BOUNDARY = 49.00    # Montana/Canada border
  DEFAULT_SOUTH_BOUNDARY = 35.685   # center of Santa Fe
  DEFAULT_EAST_BOUNDARY  = -102.042 # eastern edge of Colorado
  DEFAULT_WEST_BOUNDARY  = -116.00  # western edge of Montana
  ALL_FEATURE_TYPES      = GeoFeature.pluck(:feature_class).uniq.sort

  scope :colorado,           ->                   { where(state: 'CO') }
  scope :montana,            ->                   { where(state: 'MT') }
  scope :new_mexico,         ->                   { where(state: 'NM') }
  scope :wyoming,            ->                   { where(state: 'WY') }
  scope :default_search,     ->                   { where(feature_name: 'Lander') } # TODO: change to "Forrest Fenn" or something similar
  scope :random_search,      ->                   { order("RANDOM()").limit(1) }
  scope :with_keyword,       -> (keyword)         { where("lower(feature_name) LIKE '%#{keyword.downcase}%'") }
  scope :with_states,        -> (states)          { where(state: states) }
  scope :with_elevation,     -> (elevation_range) { where(elevation: elevation_range) }
  scope :with_feature_types, -> (feature_types)   { where(feature_class: feature_types) }
  scope :with_county,        -> (county)          { where("lower(county) = '#{county.downcase}'") }
  # scope :with_county,        -> (county)          { where(county: county) } # requires correct capitalization of county param


  def self.search(params)
    Rails.logger.debug "GeoFeature params: #{params.inspect}"
    if params.present? && params[:query].present?
      queries       = params[:query].split(', ').map(&:strip)
      states        = params[:states]
      elevation     = params[:elevation]
      feature_types = params[:feature_types]
      county        = params[:county]
      coordinates   = params[:coordinates]

      Rails.logger.debug "GeoFeature query: #{queries.inspect}"

      query_params                                            = {}
      query_params[:elevation]                                = sanitize_elevation(elevation)
      query_params[:lat_decimal], query_params[:long_decimal] = sanitize_coordinates(coordinates)
      query_params[:state]                                    = sanitize_states(states)               if states.present?
      query_params[:feature_class]                            = sanitize_feature_types(feature_types) if feature_types.present?
      query_params[:county]                                   = sanitize_counties(county)             if county.present?

      Rails.logger.debug "query_params: #{query_params.inspect}"

      queries.map.with_index do |query, index|
        search_results = GeoFeature.with_keyword(query).where(query_params)
        { query => { landings: search_results, marker: select_marker[index] }}
      end
    else
      search_results = [{ nil => { landings: [], marker: nil }}]
    end

    # Rails.logger.debug "search-results: #{search_results.inspect}"

    # search_results = [] if search_results.nil? || search_results.empty?
    # TODO: return message to user explaining why search returned no results

  end

  def self.sanitize_feature_query(query)
    # strip quotes and other special characters
    # split queries with spaces?? if "Colorado Springs" was split, there would be too many results: "Colorado" & "Springs"
    # split queries with commas??
    "lower(feature_name) LIKE '%#{query.downcase}%'"
  end

  def self.sanitize_states(states)
    # the 'states' param should always be an array, not a string of a single state
    states ||= DEFAULT_STATES
  end

  def self.sanitize_elevation(elevation)
    # options: default elevation boundaries, all elevations, user-defined elevation boundaries

    if elevation.nil? # searches sent from navbar don't have 'elevation' param
      DEFAULT_ELEVATION_LOW..DEFAULT_ELEVATION_HIGH
    else
      low  = elevation[:lowest].present?  ? elevation[:lowest].to_i  : DEFAULT_ELEVATION_LOW
      high = elevation[:highest].present? ? elevation[:highest].to_i : DEFAULT_ELEVATION_HIGH

      # TODO: validate that high-elevation is higher than low-elevation
      # TODO: validate that numbers are both positive (and that 'high' is above 0)

      low..high
    end
  end

  def self.include_elevation?(elevation)
    elevation[:lowest].present? || elevation[:highest].present?
  end

  def self.sanitize_feature_types(feature_types)
    feature_types ||= ALL_FEATURE_TYPES
  end

  def self.sanitize_counties(county)
    # NOTE: there are 22 features that do not have a county.
    county
  end

  def self.sanitize_coordinates(coordinates)
    if coordinates.nil? # searches sent from navbar don't have 'coordinates' param
      default_coordinates
    else
      north = coordinates[:north].present? ? coordinates[:north].to_f : DEFAULT_NORTH_BOUNDARY
      south = coordinates[:south].present? ? coordinates[:south].to_f : DEFAULT_SOUTH_BOUNDARY
      east  = coordinates[:east].present?  ? coordinates[:east].to_f  : DEFAULT_EAST_BOUNDARY
      west  = coordinates[:west].present?  ? coordinates[:west].to_f  : DEFAULT_WEST_BOUNDARY

      # TODO: return warning if south is higher than north or west is higher than east

      [south..north, west..east]
    end
  end

  def self.default_coordinates
    [DEFAULT_SOUTH_BOUNDARY..DEFAULT_NORTH_BOUNDARY, DEFAULT_WEST_BOUNDARY..DEFAULT_EAST_BOUNDARY]
  end

  def self.select_marker
    [
      "http://maps.google.com/mapfiles/ms/icons/purple.png",
      "http://maps.google.com/mapfiles/ms/icons/orange.png",
      "http://maps.google.com/mapfiles/ms/icons/green.png",
      "http://maps.google.com/mapfiles/ms/icons/blue.png"
    ]
  end

end