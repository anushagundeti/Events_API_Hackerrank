Rails.application.routes.draw do
  resources :events, only: [:index, :show]

  resources :repos, only: [] do
    resources :events, only: [:create] do
      collection do
        get '/', to: 'events#index_by_repo'
      end
      member do
        get '/', to: 'events#show_by_repo'
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
