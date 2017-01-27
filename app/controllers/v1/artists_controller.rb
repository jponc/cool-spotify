class V1::ArtistsController < ApplicationController
  def index
    artists = ArtistService::Search.query(params[:query])
    data =
      artists.map do |artist|
        data = {}
        %w(id name external_urls genres href).each do |attribute|
          data[attribute] = artist[attribute]
        end
        data
      end
    render json: { data: data }
  end

  def mark_as_favorite
    favorite = ArtistService::Find.new(params[:id]).mark_as_favorite
    render json: { data: favorite }
  end

  def remove_from_favorites
    ArtistService::Find.new(params[:id]).remove_from_favorites
    render json: { success: true }
  end
end
