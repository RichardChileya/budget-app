Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root "categories#index"
  resources :categories, only:[ :index, :new, :show, :create] do
    resources :dealings, only:[ :new, :create, :destroy]
  end
end


# root GET    /                                                                                                 categories#index
# category_dealings POST   /categories/:category_id/dealings(.:format)                                                       dealings#create
# new_category_dealing GET    /categories/:category_id/dealings/new(.:format)                                                   dealings#new
#  category_dealing DELETE /categories/:category_id/dealings/:id(.:format)                                                   dealings#destroy
#        categories GET    /categories(.:format)                                                                             categories#index
#                   POST   /categories(.:format)                                                                             categories#create
#      new_category GET    /categories/new(.:format)                                                                         categories#new
#          category GET    /categories/:id(.:format)                                                                         categories#show