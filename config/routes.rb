Rails.application.routes.draw do
  resources :leads
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "leads#index"
end
