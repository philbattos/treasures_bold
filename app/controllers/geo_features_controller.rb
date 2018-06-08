class GeoFeaturesController < ApplicationController

  def index
    puts "params: #{params.inspect}"
    # @geo_features = GeoFeature.all
    @search_results = GeoFeature.search(params[:search])
  end

  def show
    @geo_feature = GeoFeature.find(params[:id])
  end

end