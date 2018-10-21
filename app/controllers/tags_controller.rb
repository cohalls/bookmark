class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.create(tag_params)
    redirect_to links_path
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
