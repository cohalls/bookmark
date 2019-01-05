class SearchController < ApplicationController

  def search
    @tag = Tag.find_by(title: params[:tag], user: current_user)
    if @tag
      @links = @tag.links
      render "links/index"
    else
      flash[:error] = "There are no Links with the Tag #{params[:tag]}"
      @links = Link.all
      render "links/index"
    end
  end

  def search_params
    params.require(:tag)
  end
end
