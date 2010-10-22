TimelineMaker::Application.routes.draw do

  match "/images/uploads/*path" => "gridfs#serve"

  resources :timelines do
    resources :events, :only => [:new, :create]
  end

  root :to => "timelines#index"

end
