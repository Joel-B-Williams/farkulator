Rails.application.routes.draw do

  root to: "static#home"

  resources :games do
    resources :players
  end

end
