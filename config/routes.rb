Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/author', to: 'authors#index'
  get '/author/search', to: 'authors#search', as: 'git_log_search_form'
end
