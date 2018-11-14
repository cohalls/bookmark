class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.create!(tag_params.merge!(user: current_user))
    redirect_to links_path
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find((params[:id]))
    @tag.update(tag_params)
    redirect_to tag_path(@tag)
  end

  def destroy
    @tag = Tag.destroy(params[:id])
    redirect_to tags_path
  end

  private

  def tag_params
      params.require(:tag).permit(:title)
  end
end
