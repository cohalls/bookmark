class LinksController < ApplicationController
  def index
    @links = Link.all
  end

  def new
    @link = Link.new
  end
  def create
    @link = Link.create(link_params)
  end

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
