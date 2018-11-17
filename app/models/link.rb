require 'link_thumbnailer'
class Link < ApplicationRecord
  has_and_belongs_to_many :tags
  belongs_to :user
  before_save :crawl_page

  def crawl_page
    page = LinkThumbnailer.generate(self.url)
    image = page.images.first.src.to_s
    self.image_path = image
  end
end
