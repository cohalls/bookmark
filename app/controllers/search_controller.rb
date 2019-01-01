class SearchController < ApplicationController

  def search

  end

  def search_params
    params.require(:link).permit(:title, :url, :tags => [])
  end
end
