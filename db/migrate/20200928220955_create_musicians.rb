class CreateMusicians < ActiveRecord::Migration[6.0]
  def change
    create_table :musicians do |t|
      t.string :name
      t.string :instrument 
      t.string :location
      t.string :bio
      t.integer :years_experience

      t.timestamps
    end
  end
end
