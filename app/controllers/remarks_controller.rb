class RemarksController < ApplicationController

  def new
    @remark = Remark.new
  end

  def create
    @remark = Remark.new(remark_params)

    if @remark.save
    	RemarksMailer.contact_form(@remark).deliver
      flash.now[:error] = nil
      redirect_to :contact, notice: 'Your message was sent. Thank you!'
    else
      flash.now[:error] = 'Cannot send message'
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_remark
      @remark = Remark.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def remark_params
      params.require(:remark).permit(:name, :email, :message)
    end
end