class SupportController < ApplicationController


  def home; end

  def advanced_search
    if params[:search]
      # if search form has been submitted with :search param
      redirect_to geo_features_path(search: search_params)
    else
      # render advanced-search page
    end
  end


  private

    def search_params
      params.require(:search).permit(:query, {states: []}, {elevation: [:lowest, :highest]}, {coordinates: [:north, :east, :south, :west]}, {feature_types: []}, :county)
    end

end
