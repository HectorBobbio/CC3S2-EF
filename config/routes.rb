Rottenpotatoes::Application.routes.draw do
  resources :users
  resources :movies
  # map '/' to be a redirect to '/movies'
  get '/search_tmdb' => 'movies#search_tmdb'
  root :to => redirect('/movies')
  end
