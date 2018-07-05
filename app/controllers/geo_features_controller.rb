class GeoFeaturesController < ApplicationController

  def index
    puts "params: #{params.inspect}"
    # @geo_features = GeoFeature.all
    @search_results    = GeoFeature.search(params[:search])
    gon.search_results = @search_results
    gon.results_count  = @search_results.values.first[:landings].count
  end

  def show
    @geo_feature = GeoFeature.find(params[:id])
  end

end