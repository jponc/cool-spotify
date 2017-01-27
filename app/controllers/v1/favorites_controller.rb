class V1::FavoritesController < ApplicationController
  def index
    render json: Favorite.all
  end
end

