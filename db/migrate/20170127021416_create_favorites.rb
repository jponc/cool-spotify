class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.string :spotify_id
      t.jsonb :external_urls
      t.jsonb :genres
      t.string :href
      t.string :name

      t.timestamps
    end
  end
end
