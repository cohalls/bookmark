class LinksController < ApplicationController
  def index
    @links = Link.all
  end
  def show
    @link = Link.find(params[:id])
  end
  def new
    @link = Link.new
  end
  def create
    @link = Link.create(link_params)
  end
  def edit
    @link = Link.find(params[:id])
  end
  def update
    @link = Link.find(params[:id])
    @link.update(link_params)
    redirect_to link_path(@link)
  end
  private

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
