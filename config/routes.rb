Rails.application.routes.draw do
  #home page is default page
  root "pages#home" 
  
  #home page
  get "/home", to: 'pages#home'

  resources :recipes do
    member do
      post 'like'
    end
  end
  
  resources :chefs, except: [:new]
  get "/register", to: 'chefs#new'
  
  
  get '/login', to: "logins#new"
  post '/login', to: "logins#create"
  get '/logout', to: "logins#destroy"
end
