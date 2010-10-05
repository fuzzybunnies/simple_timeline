TimelineMaker::Application.routes.draw do
  resources :timelines

  root :to => "timelines#index"

end
