class SelfserviceController < ApplicationController

  before_filter :require_attendee

  def hello
    @event = @attendee.event
  end
  
  def social
  end
  
  def notcoming
    
  end
  
  def thankyou
  end
  
end