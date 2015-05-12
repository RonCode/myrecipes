Rails.application.routes.draw do
  #home page is default page
  root "pages#home" 
  
  #home page
  get "/home", to: 'pages#home'

  resources :recipes
end
