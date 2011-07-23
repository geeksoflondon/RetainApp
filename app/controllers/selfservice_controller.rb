class SelfserviceController < ApplicationController

  before_filter :require_attendee

  def hello
    @event = @attendee.event
  end
  
end