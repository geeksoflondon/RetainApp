RetainApp::Application.routes.draw do

  resources :attendees, :only => [:show, :new, :edit, :create, :update, :destroy]
  match 'attendees/bulkimport' => 'attendees#bulkimport', :via => [:post]

  resources :events
  match 'onenight' => 'events#onenight'
  match 'events/:id/:filter_type/:filter' => 'events#show'

  resources :onsite

  #badges
  match 'badge/attendee/:id' => 'badges#individual'
  match 'badge/event/:id' => 'badges#event'

  #self service
  match 'selfservice/' => 'selfservice#index'
  match 'selfservice/hello' => 'selfservice#hello'
  match 'selfservice/coming' => 'selfservice#coming'
  match 'selfservice/notcoming' => 'selfservice#notcoming'
  match 'selfservice/cancel' => 'selfservice#cancel'
  match 'selfservice/badge' => 'selfservice#badge'
  match 'selfservice/updatebadge' => 'selfservice#updatebadge'
  match 'selfservice/thankyou' => 'selfservice#thankyou'

  #authentication
  match '/auth/twitter/setup', :to => 'authentications#setup'
  match '/auth/:provider/callback' => 'authentications#create'
  match '/oneclick/:token' => 'authentications#oneclick'
  match '/auth/failure' => redirect("/")
  match '/login' => redirect('/auth/twitter'), :as => "login"
  match '/logout' => "authentications#destroy", :as => "logout"


  root :to => 'welcome#index'

end
