class SelfserviceController < ApplicationController

  before_filter :require_attendee
  before_filter :load_common

  def hello
    
  end
  
  def social
  end
  
  def badge
  end
  
  def notcoming
  end
  
  def cancel
  end
  
  def thankyou
  end

  def load_common
    @event = @attendee.event
  end
  
end