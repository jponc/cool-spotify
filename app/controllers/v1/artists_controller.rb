class V1::ArtistsController < ApplicationController
  def index
    artists = ArtistService::Search.query(params[:query])
    data =
      artists.each_with_index.map do |artist, idx|
        format_artist(artist, idx)
      end
    render json: { data: data }
  end

  def show
    artist = ArtistService::Find.new(params[:id]).artist
    render json: { data: format_artist(artist, 0) }
  end

  def mark_as_favorite
    favorite = ArtistService::Find.new(params[:id]).mark_as_favorite
    render json: { data: favorite }
  end

  def remove_from_favorites
    ArtistService::Find.new(params[:id]).remove_from_favorites
    render json: { success: true }
  end

  private

  def format_artist(artist, idx)
    data = {}

    %w(id name external_urls genres href).each do |attribute|
      data[attribute] = artist[attribute]
    end

    # NOTE: Default should be the first result? Since it's more popular?
    data['default'] = idx == 0

    # NOTE: LOL NO LOGIC FOR DEFAULT JUST CHECKED IF IT'S A FAVORITE
    # data['default'] = Favorite.find_by(spotify_id: artist['id']).any?
    data
  end
end
