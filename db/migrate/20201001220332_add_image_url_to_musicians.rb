class AddImageUrlToMusicians < ActiveRecord::Migration[6.0]
  def change
    add_column :musicians, :img_url, :string
  end
end
