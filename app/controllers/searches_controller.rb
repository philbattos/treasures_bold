class SearchesController < ApplicationController
  before_action :set_search, only: [:show, :destroy]
  before_filter :authenticate_user!, only: [:index, :destroy]
  load_and_authorize_resource except: [:new, :create]
  # layout "homepage", only: :new

  # GET /searches
  # GET /searches.json
  def index
    @searches = Search.all
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
  end

  def new
    @search = Search.new
    render :layout => 'homepage'
  end

  # POST /searches
  # POST /searches.json
  def create
    redirect_to search_results_path(params: params)
    begin
      # @search = Search.new(search_params)
      @search = current_user.searches.build(search_params)
      @search.save || Search.new(params).save
    rescue Exception => exc 
      # send message to log or database or somewhere if @search is not saved
      logger.error "Error saving a search: #{exc.message}"
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to searches_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = Search.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:verbatim, :terms)
    end
end
