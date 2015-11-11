Rails.application.routes.draw do

  root 'home#index'

  get 'test' => 'home#test_query'

  get 'routes/all' => 'home#all_routes'

  get 'hist/all' => 'home#all_hist'

  post 'routes/near' => 'home#near_routes'

  post 'routes/comp' => 'home#comp_routes'


end
