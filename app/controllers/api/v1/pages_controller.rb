class Api::V1::PagesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_page, only: [:show, :update, :destroy, :page_contents]

  def index
    @pages = Page.all
    render json: @pages.to_json(:include => [:page_contents])
  end

  def show
    render json: @page.to_json(:include => [:page_contents])
  end
  
  def create
    @page = Page.new(page_params)
    if params[:page_url].present?
    	if @page.save
      	render json: @page
    	else
      	render json: @page.errors
    	end
    end
  end

  
  def update
    if @page.update(page_params)
      render json: @page
    else
      render json: @page.errors
    end
  end

  
  def destroy
    @page.destroy
  end

  def page_contents
    render json: @page.page_contents
  end

  private
  
    def set_page
      @page = Page.find(params[:id])
    end
  
    def page_params
      # params.require(:page).permit(:page_url)
      params.permit(:page_url)
    end
end
