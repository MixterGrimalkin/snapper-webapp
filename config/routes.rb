Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/' => 'application#last_drop'
  get '/last_drop_image' => 'application#last_drop_image'
  get 'drops' => 'application#drops'
  get '/drop/:id' => 'application#drop'
  post '/drop/:id/save' => 'application#save_drop'

end
