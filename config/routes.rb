Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
  	namespace :v1 do
  		resources :page_contents
  		resources :pages do 
  			member do 
  				get :page_contents
  			end
  		end
  	end
  end
end
