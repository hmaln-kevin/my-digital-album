Rails.application.routes.draw do
  devise_for :users
  resources :figures
  get 'open_pack', to: 'figures#open_pack'
  
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
end
