TimelineMaker::Application.routes.draw do
  resources :timelines do
    resources :events, :only => [:new, :create]
  end

  root :to => "timelines#index"

end
