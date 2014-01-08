class QueriesController < ApplicationController
  before_action :set_query, only: [:show, :destroy]
  # before_filter :authenticate_user!, only: [:index, :destroy]
  load_and_authorize_resource except: [:new, :create]
  # layout "homepage", only: :new

  ### new search on homepage
  ### move to a separate controller?
  def home
    @query = Query.new
  end

  # GET /queries
  # GET /queries.json
  ### list of all searches entered (only visible to admins)
  def index
    @queries = Query.all
  end

  # GET /queries/1
  # GET /queries/1.json
  ### show a specific search (only visible to admins)
  def show
    # @query = Query.find(params[:id])
  end

  ### enter a new search (from advanced_search page)
  def new
    @query = Query.new
    # render :layout => 'homepage'
  end

  # POST /queries
  # POST /queries.json
  ### redirect to perform search and return results
  ### create a new search entry in database
  def create
    # @query = Query.new(params)
    # sends search request to landings_controller to process
    redirect_to search_landings_path(params: params)
    begin
      # creates new database entry for search query
      @query = Query.new(query_params)
      # @query = current_user.queries.build(query_params)
      @query.save || Query.new(params).save
    rescue Exception => exc 
      # send message to log or database or somewhere if @query is not saved
      logger.error "Error saving a query: #{exc.message}"
    end
  end

  # DELETE /queries/1
  # DELETE /queries/1.json
  ### delete search query
  def destroy
    @query.destroy
    respond_to do |format|
      format.html { redirect_to queries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_query
      @query = Query.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def query_params
      # params.require(:query).permit(entries: [entry1: [:keyword, fields: [:feature_name]]], filters: [:exclude, :elevation_5000, :elevation_min, :elevation_max])
      params.require(:query)
    end
end
