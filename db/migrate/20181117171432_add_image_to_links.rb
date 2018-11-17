class AddImageToLinks < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :image_path, :string
  end
end
