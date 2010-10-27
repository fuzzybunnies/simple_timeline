TimelineMaker::Application.routes.draw do

  match "/images/uploads/*path" => "gridfs#serve"

  resources :timelines do
    resources :events, :except => [:destroy]
  end

  root :to => "timelines#index"

end
