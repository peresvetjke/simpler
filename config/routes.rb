Simpler.application.routes do
  get '/tests', 'tests#index'
  get '/tests/:id/', 'tests#show'
  get '/tests/:test_id/questions/:id/', 'tests#index'
  post '/tests', 'tests#create'
end
