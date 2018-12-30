class Tag < ApplicationRecord
  belongs_to :links
  belongs_to :user

  def formatted_id
    return "#{self.id}::#{self.title}"
  end

end
