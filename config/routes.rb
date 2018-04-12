Rails.application.routes.draw do
  get '/' => 'application#index'
  
  scope '/:board' do
    get '/' => 'topics#index', as: :board
    resources :topics, only: [:show] do
      member do
        get :omitted
      end
    end
    resources :posts, only: [:create, :new]
    resources :images, only: [:create]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
