TimelineMaker::Application.routes.draw do

  devise_for :users

  match "/images/uploads/*path" => "gridfs#serve"

  resources :timelines do
    resources :events, :except => [:destroy]
  end

  root :to => "timelines#index"

end
