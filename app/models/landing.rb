class Landing < ActiveRecord::Base
	include Tire::Model::Search
	include Tire::Model::Callbacks

	validates :feature_id, presence: true
	validates :feature_name, presence: true
	validates :lat_decimal, presence: true
	validates :long_decimal, presence: true

	tire.mapping do
		indexes :feature_id, :type => :integer, :index => :not_analyzed
		indexes :feature_name 
		indexes :feature_class 
		indexes :state
		indexes :county
		indexes :elevation, :type => :integer
		indexes :elev_in_meters, :type => :integer
		indexes :lat_degrees
		indexes :long_degrees
		indexes :lat_decimal, :type => :decimal
		indexes :long_decimal, :type => :decimal
		indexes :map_name
	end

	# landings = Landing.all
	# Tire.index 'landings' do
	# 	import landings
	# end

	### Redefine Tire's Search method
	# Note: currently default search finds *any* matching instance
	# ex. search for "spring mountain" returns anything matching "spring" or "mountain"
	def self.search(params)
		tire.search do
			size 100 # number of search results returned
			query do
				# string params if params.present?
				boolean do
					must { string params } if params.present?
	        # must { string 'state_alpha:' + params[:select_state].keys.join(' OR state_alpha:') } if params[:select_state].present?
	        # must { range :elev_in_ft, {gte: params[:elevation_5000] ? 5000 : 0} } 
				end
			end
		end
	end

	def self.marker_color 
		[ "http://maps.google.com/mapfiles/ms/icons/green.png",
			"http://maps.google.com/mapfiles/ms/icons/blue.png",
			"http://maps.google.com/mapfiles/ms/icons/pink.png",
			"http://maps.google.com/mapfiles/ms/icons/orange.png",
			"http://maps.google.com/mapfiles/ms/icons/purple-dot.png",
			"http://maps.google.com/mapfiles/ms/icons/yellow-dot.png" ]
	end

	def self.compile_search_data(search_query)
		search_results = Hash.new { |hash,key| hash[key] = {} }
		search_terms = search_query.split(" ")
		search_terms.each_with_index do |term, index| 
		  term = term.to_sym
		  search_results[term][:landings] = search term
		  search_results[term][:marker] = marker_color[index]
		end
		search_results
	end

end
