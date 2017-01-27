Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1 do
    resources :artists, only: %i(index) do
      member do
        post :mark_as_favorite
        post :remove_from_favorites
      end
    end

    resources :favorites, only: :index
  end
end
