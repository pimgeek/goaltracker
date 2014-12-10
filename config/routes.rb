Rails.application.routes.draw do


  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_scope :user do 
    get "/users/:username" => 'users#show'
  end
  
  root 'home#index'


  resources :topics do
    collection do
      get :search
    end

    resources :reply, :shallow => true
  end



  # if ::Rails.env.production? 
    match '*path', via: :all, to: 'home#error_404'
  # end

end
