class SupportController < ApplicationController

  def home; end

  def advanced_search
    if params[:search]
      # if search form has been submitted with :search param
      redirect_to map_path(search: search_params)
    else
      # render advanced-search page
    end
  end

  def map
    puts "params: #{params.inspect}"
    @search_results    = GeoFeature.search(params[:search])
    gon.search_results = @search_results
    gon.results_count  = @search_results.map {|result| result.values.first[:landings].count }.sum
  end


  private

    def search_params
      params.require(:search).permit(:query, {states: []}, {elevation: [:lowest, :highest]}, {coordinates: [:north, :east, :south, :west]}, {feature_types: []}, :county)
    end

end
