RetainApp::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

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

  #self service oneclick
  match '/oneclick/:token' => 'selfservice#oneclick'
  match '/logout' => "selfservice#destroy", :as => "logout"

  #qjump
  match 'qjump/:token' => 'qjump#index'
  match 'qjump/barcode/:token' => 'qjump#barcode'

  #checkin
  match 'checkin' => 'checkin#index'
  match 'checkin/attendees' => 'checkin#attendees'
  match 'checkin/attendee/:id' => 'checkin#attendee'
  match 'checkin/issue/:id' => 'checkin#issue'
  match 'checkin/stats' => 'checkin#stats'
  match 'checkin/login' => 'checkin#login'
  match 'checkin/qrlogin/:token' => 'checkin#qrlogin'
  match 'checkin/scanner' => 'checkin#scanner'
  match 'checkin/app/:token' => 'checkin#app'

  #hacks
  match 'current_event.json' => 'welcome#current_event_stats'

  root :to => 'welcome#index'

end
