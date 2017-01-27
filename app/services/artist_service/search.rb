module ArtistService
  class Search
    def self.query(query)
      query ||= ''
      new(query).find_all
    end

    def initialize(query)
      @query = query
    end

    def find_all
      artists['items'] rescue []
    end

    private

    def artists
      @artists ||= response['artists']
    end

    def response
      @response ||= HTTParty.get(artist_search_url)
    end

    def artist_search_url
      "https://api.spotify.com/v1/search?type=artist&limit=50&q=#{@query}"
    end
  end
end
