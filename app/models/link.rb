require 'link_thumbnailer'

class Link < ApplicationRecord
  has_and_belongs_to_many :tags
  belongs_to :user

  before_validation :format_url
  before_save :crawl_page

  validates :url, format: { with: URI::regexp(['http', 'https']) }

  def crawl_page
    page = LinkThumbnailer.generate(self.url)
    image = page.images.first.src.to_s
    self.image_path = image
    description = page.description
    self.description = description
  end

  def format_url
    self.url = "http://#{self.url}" unless self.url[/^https?/]
  end
end
