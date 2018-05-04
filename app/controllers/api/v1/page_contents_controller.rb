class Api::V1::PageContentsController < ApplicationController
  skip_before_filter :verify_authenticity_token
	before_action :set_page_content, only: [:show, :update, :destroy] 
  
  def index
    @page_contents = PageContent.all
    render json: @page_contents
  end

  def show
    render json: @page_content
  end

  def create
  	# params[:content] = params[:content].force_encoding("ISO-8859-1").encode("UTF-8") if params[:content].present?
  	# params[:tag] = params[:tag].force_encoding("ISO-8859-1").encode("UTF-8") if params[:tag].present?
    @page_content = PageContent.new(page_content_params)
    if @page_content.save
      render json: @page_content
    else
      render json: @page_content.errors
    end
  end

  
  def update
    if @page_content.update(page_content_params)
      render json: @page_content
    else
      render json: @page_content.errors
    end
  end

  def destroy
    @page_content.destroy
  end

  private
    
    def set_page_content
      @page_content = PageContent.find(params[:id])
    end

    def page_content_params
      params.require(:page_content).permit(:tag, :content, :page_id_id)
    end
end
