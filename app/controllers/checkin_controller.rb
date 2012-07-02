class CheckinController < ApplicationController

  def index
    @event = Event.now
  end

  def attendees
    @attendees = Event.now.attendees.where('status != ?', 'cancelled')
  end

  def stats
    @event = Event.now
  end

end