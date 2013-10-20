class Landing < ActiveRecord::Base
	include Tire::Model::Search
	include Tire::Model::Callbacks

	validates :feature_name, presence: true
	validates :feature_class, presence: true

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

end
