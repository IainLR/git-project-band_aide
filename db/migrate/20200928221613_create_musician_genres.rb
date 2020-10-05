class CreateMusicianGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :musician_genres do |t|
      t.belongs_to :musician
      t.belongs_to :genre 
      t.timestamps
    end
  end
end
