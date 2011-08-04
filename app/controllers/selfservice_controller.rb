class SelfserviceController < ApplicationController

  before_filter :require_attendee
  before_filter :require_confirmed, :except => [:index, :hello, :coming, :cancel]
  # before_filter :require_unconfirmed, :except => [:coming, :cancel]
  before_filter :load_common


  def index
    redirect_to selfservice_hello_path
  end

  def hello
    #Not much to do here apart from show the hello screen.
  end

  def coming
    @attendee.status = 'confirmed'
    @attendee.save
    redirect_to selfservice_badge_path
  end

  def badge
    #Show the badge
  end
  
  def updatebadge
    if @attendee.update_attributes(params[:attendee])
      redirect_to selfservice_thankyou_path
    else
      render :action => "badge"
    end
  end

  def notcoming
    #Not much to do here apart from show the double-out screen.
  end

  def cancel
    @attendee.status = 'cancelled'
    @attendee.save
    redirect_to selfservice_thankyou_path
  end

  def thankyou
    #Not much to do here apart from show the thankyou screen.
  end

  def require_confirmed
    unless @attendee.status == 'confirmed'
    end
  end

  def load_common
    @event = @attendee.event
  end

end