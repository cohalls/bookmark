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
    link_parameters = link_params
    array_of_tags = []
    link_parameters[:tags].each do |tag_id|
      next if tag_id.empty?
      array_of_tags.push(Tag.find(tag_id))
    end
    link_parameters[:tags] = array_of_tags
    @link = Link.create(link_parameters.merge!(user: current_user))
    redirect_to links_path
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find((params[:id]))
    @link.update(link_params)
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
