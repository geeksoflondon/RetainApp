class CheckinController < ApplicationController

  def index
  end

  def attendees
    @attendees = Event.now.attendees.where('status != ?', 'cancelled')
  end

end