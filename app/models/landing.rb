class Landing < ActiveRecord::Base
	include Tire::Model::Search
	include Tire::Model::Callbacks
	# Callbacks automatically indexes a record that is created, updated, or destroyed

	validates :feature_id, presence: true
	# validates :feature_name, presence: true
	validates :lat_decimal, presence: true
	validates :long_decimal, presence: true

	tire.mapping do
		indexes :feature_id, :type => :integer, index: :not_analyzed
		indexes :feature_name 
		indexes :feature_class 
		indexes :state
		indexes :county
		indexes :elevation, :type => :integer
		indexes :lat_decimal, :type => :float
		indexes :long_decimal, :type => :float
		# indexes :elev_in_meters, :type => :integer
		# indexes :lat_degrees
		# indexes :long_degrees
		# indexes :map_name
	end
	
	def self.compile_results(search_query)
		search_results = Hash.new { |hash, key| hash[key] = {} }
		filters = search_query[:filters]
		entries = search_query[:entries]

		entries.each do |name, data|
			keyword = data[:keyword].to_sym
			next if keyword.empty?
			search_results[keyword][:landings] = search(data, filters)
			search_results[keyword][:marker] = select_marker(name)
			search_results[keyword][:total_found] = search_results[keyword][:landings].size
		end

		# restrict number of results to be mapped
		# search_results.each {|keyword, map_data| map_data[:landings] = map_data[:landings][0..9] }
		
		search_results
	end

	def self.search(entry, filters=nil)
		tire.search do # (load: true) tells Tire to search objects in database, not indexed objects (Railscast #306)
			size 1000
			query do
				boolean do
					selected_fields = entry[:fields].keys
					keyword = entry[:keyword]
					selected_fields.each do |field|
						should { string "#{field}:#{keyword}", default_operator: 'AND' }
					end
					must_not { string "#{filters[:exclude]}" } if filters[:exclude].present?
				end
			end
			min_elevation = filters[:elevation_min] if filters.present?
			max_elevation = filters[:elevation_max] if filters.present?
			north_bound = filters[:north_bound] if filters.present?
			south_bound = filters[:south_bound] if filters.present?
			east_bound = filters[:east_bound] if filters.present?
			west_bound = filters[:west_bound] if filters.present?
			### filters have specified types: :terms, :range, ??
			filter :terms, state: filters[:select_states].keys
			filter :range, lat_decimal: { lte: north_bound.to_f } if north_bound.present?
			filter :range, lat_decimal: { gte: south_bound.to_f } if south_bound.present?
			filter :range, long_decimal: { gte: east_bound.to_f } if east_bound.present?
			filter :range, long_decimal: { lte: west_bound.to_f } if west_bound.present?
			filter :range, elevation: { gte: 5000 } if filters[:elevation_5000].present?
			filter :range, elevation: { lte: 10200 } if filters[:elevation_10200].present?
			filter :range, elevation: { gte: min_elevation } if min_elevation.present?
			filter :range, elevation: { lte: max_elevation } if max_elevation.present?
			# change from 'lte' or 'gte' to 'from' and 'to' (see tire/elasticsearch pages for details)
		end
	end

	def self.select_marker(entry)
		marker_color[entry.slice(-1).to_i - 1]
	end

	private

		def self.marker_color 
			[ "http://maps.google.com/mapfiles/ms/icons/green.png",
				"http://maps.google.com/mapfiles/ms/icons/blue.png",
				"http://maps.google.com/mapfiles/ms/icons/pink.png",
				"http://maps.google.com/mapfiles/ms/icons/orange.png",
				"http://maps.google.com/mapfiles/ms/icons/purple.png",
				"http://maps.google.com/mapfiles/ms/icons/yellow.png",
			  "http://maps.google.com/mapfiles/ms/micons/red-pushpin.png",
				"http://maps.google.com/mapfiles/ms/icons/yellow-dot.png" ]
		end

end

### current format of search_query:
# { filters:
#   { elevation_5000: "yes",
#     elevation_max: "",
#     elevation_min: "",
#     exclude: "river" },
#   entries: 
#   { entry1: 
#     { fields: 
#       { feature_name: "on" }
#       keyword: "spring mountain" 
#     }
#     entry2:
#     { fields: 
#       { feature_name: "on" }
#       keyword: "spring mountain" 
#     }
#   }
# }

# view expects this format:
# { search_results: 
#   { keyword: (search_term),
#     map_data:
#     { landings: Tire...,
#       marker: (link)
#     }
#   }
# }

### Redefine Tire's Search method
# Note: currently default search finds *any* matching instance
# ex. search for "spring mountain" returns anything matching "spring" or "mountain"
# def self.search(search_query)
# 	filters = search_query[:filters]
# 	entries = search_query[:entries]
# 	tire.search do
# 		# size 100 # number of search results returned
# 		query do
# 			# string search_query if search_query.present?
# 			boolean do
# 				# entry1 = entries[:entry1]
# 				# keyword = entry1[:keyword]
# 				# fields = entry1[:fields].keys
# 				exclude_keyword = filters[:exclude]

# 				if entries.count > 1
# 					entries.each do |key, value|
# 						value[:fields].keys.each do |field|
# 							should { string "#{field}:#{value[:keyword]}" }
# 						end
# 					end
# 				end

# 				# if user enters more than one keyword in search box, 
# 				# only search for landings that contain BOTH keywords
# 				# must { string entry1[:keyword], default_operator: 'AND' } if entry1[:keyword].split(" ").count > 1

# 				must_not { string "#{exclude_keyword}" }
#         must { range :elevation, { gte: 5000 }} if filters[:elevation_5000].present? 
#         must { range :elevation, { lte: 10200 }} if filters[:elevation_10200].present? 
#         must { range :elevation, { gte: filters[:elevation_min].to_i }} if filters[:elevation_min].present? 
#         must { range :elevation, { lte: filters[:elevation_max].to_i }} if filters[:elevation_max].present? 
# 				# must { string search_query, default_operator: "AND" } if search_query.present?
# 				# must { string search_query } if search_query.present?
#         # must { string 'state_alpha:' + search_query[:select_state].keys.join(' OR state_alpha:') } if search_query[:select_state].present?
# 				binding.pry
# 			end
# 		end
# 	end
# end

# landings = Landing.all
# Tire.index 'landings' do
# 	import landings
# end

### Search method that includes searching landings that contain multiple search terms
# def self.compile_search_data(search_query)
# 	search_results = Hash.new { |hash,key| hash[key] = {} }
# 	@search_terms = search_query.split(',')
# 	valid_search_size?
# 	combine_search_terms
# 	@search_terms.reverse!
# 	@search_terms.each_with_index do |term, index| 
# 	  term = term.to_sym
# 	  search_results[term][:landings] = search term
# 	  search_results[term][:marker] = marker_color[index]
# 	end
# 	# search_results[search_terms][:landings] = search search_query
# 	# search_results[search_terms][:marker] = marker_color[4]
# 	search_results
# end

# def self.valid_search_size?
# 	true if @search_terms.size < 4 # && search_query.split(" ").size < 4
# end

# def self.combine_search_terms
# 	count = @search_terms.count
# 	first_term = @search_terms[0]
# 	second_term = @search_terms[1]
# 	third_term = @search_terms[2]

# 	if count > 1
# 		@search_terms << first_term + " &" + second_term
# 		if count > 2
# 			@search_terms << first_term + " &" + third_term
# 			@search_terms << second_term + " &" + third_term
# 			@search_terms << first_term + " &" + second_term + " &" + third_term
# 		end
# 	end
# end

