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
    @link = Link.create!(check_tags.merge!(user: current_user))
    redirect_to links_path
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find((params[:id]))
    @link.update(check_tags.merge!(user: current_user))
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

  def check_tags
    # Because of the way Select2 works, I had to create this check_tags method.
    # Select2 always gives an empty tag_id, so I skipped it if it was empty
    # My view's tag_id is in a special format I created to combine the id number with the title or value entered.
    # This is because Select2 would give the id if it was already created and just the value entered if it was new.
    # Then I checked the length of the split_id after I split on the delimiter.
    # This separates the tags that were in the database from the tags that must be created.
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
    link_parameters
  end

end
