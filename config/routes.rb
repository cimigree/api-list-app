Rails.application.routes.draw do 
  resources :categories do
    resources :items
  end
  resources :stores do
    resources :items
  end
  resources :items
end
