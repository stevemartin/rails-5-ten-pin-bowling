Rails.application.routes.draw do
  resources :shots
  shallow do
    resources :games do
        end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
