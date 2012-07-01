RetainApp::Application.routes.draw do

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

  #qjump
  match 'qjump/:token' => 'qjump#index'
  match 'qjump/barcode/:token' => 'qjump#barcode'

  #authentication
  match '/oneclick/:token' => 'authentications#oneclick'
  match '/logout' => "authentications#destroy", :as => "logout"

  root :to => 'welcome#index'

end
