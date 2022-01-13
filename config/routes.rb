Rails.application.routes.draw do
  get "/articles", to: "articles#index"
  
  get "/wish_lists", to: "wish_list#index"
  post "/wish_lists/" =>  'wish_list#create'  
  put "/wish_lists/" =>  'wish_list#update'
  delete "/wish_lists/" =>  'wish_list#delete'

  get "/epics", to: "epic#index"
  post "/epics/" => 'epic#create'
  put "/epics/" => 'epic#update'
  delete "/epics/" => 'epic#delete'

  get "/themes", to: "theme#index"
  post "/themes/" => 'theme#create'
  put "/themes/" => 'theme#update'
  delete "/themes/" => 'theme#delete'


  post "/wish_lists_multi", to: "wish_list#multi_create"

  put "/assign_manager", to: "epic#multiple_assignment"
  get "/rm_stats/" => 'epic#epicStatusByQuarter'

  get "/teams", to: "team#index"
  post "/teams/" => 'team#create'
  put "/teams/" => 'team#update'
  delete "/teams/" => 'team#delete'


  get "/architects", to: "architects#index"
  post "/architects/", to: "architects#index"


  post "/theme_create/" => 'theme#create'
  post "/architect_create/", to: "architects#create"
  get "/theme_status/" => 'theme#theme_status'
  

  post "/freshrelease_create", to: "epic#create_freshrelease_ticket"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
