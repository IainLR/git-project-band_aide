class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :commenter_id
      t.integer :commentee_id
      t.text :content
      t.integer :likes
      t.timestamps
    end
  end
end
