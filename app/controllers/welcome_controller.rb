class WelcomeController < ApplicationController

  def index
    redirect_to 'http://www.geeksoflondon.com/'
  end
  
  def current_event_stats
    @event = Event.now
    result = {:attending => @event.attended, :not_here_yet => @event.no_show}
    render :json => result.to_json, :callback => params[:callback]
  end

end