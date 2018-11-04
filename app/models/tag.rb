class Tag < ApplicationRecord
  has_and_belongs_to_many :links
  belongs_to :user

  def formatted_id
    return "#{self.id}::#{self.title}"
  end
end
