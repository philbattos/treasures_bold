class LandingsController < ApplicationController
  before_action :set_landing, only: [:show, :edit, :update, :destroy]
  before_filter :validate_search
  # before_action :import_search_query, only: [:search]
  # before_filter :authenticate_user!, except: [:search, :show]
  # before_filter :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  # load_and_authorize_resource except: [:about, :search, :show]
  # layout "application"

  def about
  end

  # GET /landings
  # GET /landings.json
  def index
  end

  def validate_search
    @entry1 = params[:query][:entries][:entry1]
    @entry2 = params[:query][:entries][:entry2]
    if keywords_blank?
      # invalidate search; return error
      redirect_to search_path, flash: { error: 'no keywords entered' }
    elsif searchable_fields_blank?
      redirect_to search_path, flash: { error: 'please select searchable fields' }
    elsif states_blank?
      redirect_to search_path, flash: { error: 'please select at least one state' }
    end
  end

  def searchable_fields_blank?
    searchable_fields1_blank? || @entry2.empty? && searchable_fields2_blank?
    # true unless searchable_fields1 
    # true unless @entry2.present? && searchable_fields2
  end

  def searchable_fields1
    @entry1[:fields].present?
  end

  def searchable_fields2
    @entry2[:fields].present?
  end

  def searchable_fields1_blank?
    @entry1[:fields].blank?
  end

  def searchable_fields2_blank?
    params[:query][:entries][:entry2][:fields].blank?
  end

  def keywords_blank?
    keyword1_blank? # if first search box is empty, return error
    # params[:query][:entries].each { |label, info| info[:keyword].blank? }
  end

  def keyword1_blank?
    @entry1[:keyword].blank?
  end

  def keyword2_blank?
    params[:query][:entries][:entry2][:keyword].blank?
  end

  def states_blank?
    params[:query][:filters][:select_states].blank?
  end


  def search
    import_search_query
    if @search_query == "[blank]"
      redirect_to search_path, notice: "There are no results for '#{@search_query}'. Please enter a new search."
    else
      @search_results = Landing.compile_results @search_query
    end
  end

  # GET /landings/1
  # GET /landings/1.json
  def show
    @landing = Landing.find_by_feature_id(params[:id])

    # if @landing
      # render layout: "application"
      # redirect_to place_path(id: @landing.feature_id)
    # elsif params[:feature_id]
      # flash[:notice] = "Please enter a valid USGS ID number"
    # else
      # render action: 'search', notice: "Invalid search"
    # end
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
      if params[:query]
        @search_query = params[:query]
      else
        @search_query = "[blank]"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def landing_params
      # the params passed to .permit are the fields that Tire searches
      params.require(:landing).permit(:feature_name, :feature_class, :state, :county)
    end
end
