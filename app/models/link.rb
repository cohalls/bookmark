require 'link_thumbnailer'

class Link < ApplicationRecord
  has_and_belongs_to_many :tags
  belongs_to :user

  before_validation :format_url
  before_save :crawl_page

  validates :url, format: { with: URI::regexp(['http', 'https']) }

  def crawl_page
    begin
      page = LinkThumbnailer.generate(self.url)
      image = page.images.first.src.to_s
      self.image_path = image
      description = page.description
      self.description = description
    rescue LinkThumbnailer::Exceptions => e
      # do nothing
    end
  end

  def format_url
    self.url = "http://#{self.url}" unless self.url[/^https?/]
  end

  def self.check_tags(link_parameters, current_user)
    # Because of the way Select2 works, I had to create this check_tags method.
    # Select2 always gives an empty tag_id, so I skipped it if it was empty
    # My view's tag_id is in a special format I created to combine the id number with the title or value entered.
    # This is because Select2 would give the id if it was already created and just the value entered if it was new.
    # Then I checked the length of the split_id after I split on the delimiter.
    # This separates the tags that were in the database from the tags that must be created.
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
