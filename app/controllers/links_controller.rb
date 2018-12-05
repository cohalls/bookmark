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
    @link = Link.create!(Link.check_tags(link_params, current_user).merge!(user: current_user))
    redirect_to links_path
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find((params[:id]))
    @link.update(Link.check_tags(link_params, current_user).merge!(user: current_user))
    redirect_to link_path(@link)
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to links_path
  end
  private

  def link_params
    params.require(:link).permit(:title, :url, :tags => [])
  end
end
