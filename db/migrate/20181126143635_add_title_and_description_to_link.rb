class AddTitleAndDescriptionToLink < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :crawled_title, :string
    add_column :links, :description, :text
  end
end
