class LandingsController < ApplicationController
  before_action :set_landing, only: [:show, :edit, :update, :destroy]
  before_action :import_search_query, only: [:index]
  before_filter :authenticate_user!, except: [:index, :show]
  # before_filter :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  load_and_authorize_resource except: [:index, :show]
  layout "application"

  # GET /landings
  # GET /landings.json
  def index
    if @search_query == "[blank]"
      redirect_to search_path, notice: "There are no results for '#{@search_query}'. Please enter a new search."
    else
      @search_results = Landing.compile_search_data @search_query
      binding.pry
      # render :layout => 'application'
      # @search_results = Landing.search @search_query
    end
  end

  def search
    @landing = Landing.find_by_feature_id(params[:feature_id])

    if @landing
      redirect_to place_path(id: @landing.feature_id)
    # elsif params[:feature_id]
      # flash[:notice] = "Please enter a valid USGS ID number"
    else
      # render action: 'search', notice: "Invalid search"
    end
  end

  # GET /landings/1
  # GET /landings/1.json
  def show
  end

  # GET /landings/new
  def new
    @landing = Landing.new
  end

  # GET /landings/1/edit
  def edit
  end

  # POST /landings
  # POST /landings.json
  def create
    @landing = Landing.new(landing_params)

    respond_to do |format|
      if @landing.save
        format.html { redirect_to @landing, notice: 'Landing was successfully created.' }
        format.json { render action: 'show', status: :created, location: @landing }
      else
        format.html { render action: 'new' }
        format.json { render json: @landing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /landings/1
  # PATCH/PUT /landings/1.json
  def update
    respond_to do |format|
      if @landing.update(landing_params)
        format.html { redirect_to @landing, notice: 'Landing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @landing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /landings/1
  # DELETE /landings/1.json
  def destroy
    @landing.destroy
    respond_to do |format|
      format.html { redirect_to landings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_landing
      @landing = Landing.find_by_feature_id(params[:id]) 
    end

    def import_search_query
      if params[:search]
        @search_query = params[:search][:verbatim]
      else
        @search_query = "[blank]"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def landing_params
      # the params passed to .permit are the fields that Tire searches
      params.require(:landing).permit(:feature_name, :feature_class)
    end
end
