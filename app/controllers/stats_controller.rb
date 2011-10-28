class StatsController < ActionController::Base

  before_filter :load_event

	def onsite
		render :layout => false, :content_type => 'application/xml'
	end
	
	def attended
  	render :layout => false, :content_type => 'application/xml'
	end

	def noshows
	  render :layout => false, :content_type => 'application/xml'
  end
	
	def load_event
	  @event = Event.now
    @checkins = Checkin.where('event_id = ?', params[:id])
    @attended = @event.attended 
		@no_shows = @event.no_show
		@total = attended + no_shows
		@att_conf = @event.attended_conf
		@att_unconf = @event.attended_unconf
		@nos_conf = @event.noshow_conf
		@nos_unconf = @event.noshow_unconf
		@onsite = @event.onsite
  end

end
