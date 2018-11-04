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
      # Why is the Tag ID empty?
      split_id = tag_id.split("::")
        if split_id.length > 1
          array_of_tags.push(Tag.find(split_id[0]))
        else
          array_of_tags.push(Tag.create!(title: split_id[0], user: current_user))
        end
    end
    link_parameters[:tags] = array_of_tags
    @link = Link.create!(link_parameters.merge!(user: current_user))
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
