class TagsController < ApplicationController
  def index
    @tags = Tags.all
  end

  def new

  end

end
