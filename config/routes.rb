Rails.application.routes.draw do

  Slug.all.each do |s|
    get "#{s.slug}", to: "#{s.slugable_type.demodulize.pluralize.downcase}#show", as: "custom_#{s.slug.demodulize.pluralize.downcase}", defaults: { id: s.slug }
    post "#{s.slug}", to: "#{s.slugable_type.demodulize.pluralize.downcase}#show", as: "post_custom_#{s.slug.demodulize.pluralize.downcase}", defaults: { id: s.slug }
  end if ActiveRecord::Base.connection.table_exists? :slugs

  resources :news
  resources :posts

  resources :tournaments do
    resources :games
  end
  resources :categories
  resources :teams
  resources :players

  get '/download/:asset_id', to: 'application#file_download', as: :download
  get '/file/:asset_id', to: 'application#file_show', as: :file_show
  # devise_for :users
  mount Ckeditor::Engine => '/ckeditor'
  mount Commontator::Engine => '/commontator'
  mount RailsAdmin::Engine => '/admin', as: :rails_admin
  # resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
  get '/search(/:searching_params)', to: 'application#search', as: :search
  get '/contact', to: 'application#contact', as: :contact

  devise_for :users, as: :frontend

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

end
