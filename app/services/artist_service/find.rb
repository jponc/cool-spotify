module ArtistService
  class Find
    def initialize(id)
      @id = id
    end

    def artist
      response
    end

    def mark_as_favorite
      favorite =
        Favorite.find_or_initialize_by(spotify_id: @id)

      favorite.update_attributes!(favorite_attributes)
      favorite
    end

    def remove_from_favorites
      if (favorite = Favorite.find_by(spotify_id: @id)).present?
        favorite.destroy
      end
    end

    private

    def favorite_attributes
      attributes = %w(external_urls id name genres href)
      response.slice(*attributes)
    end

    def response
      @response ||= HTTParty.get(artist_search_url)
    end

    def artist_search_url
      "https://api.spotify.com/v1/artists/#{@id}"
    end
  end
end
