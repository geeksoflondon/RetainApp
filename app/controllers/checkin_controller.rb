class CheckinController < ApplicationController
  
  before_filter :logged_in?, :except => [:login, :qrlogin]
  
  def login
    if params[:badge]
      user = Attendee.find(params[:badge].sub(/^[0]*/,""))
      if user.is_crew_today?
        cookies.permanent[:crew] = user.oneclick.token
        redirect_to checkin_path
      end
    end
  end
  
  def qrlogin
    if params[:token]
      user = Attendee.find(params[:token])
      if user.is_crew_today?
        cookies.permanent[:crew] = user.oneclick.token
        redirect_to checkin_path
      end
    end
  end
  
  def index
    @event = Event.now
  end

  def attendees
    @attendees = Event.now.attendees.where('status != ?', 'cancelled')
  end

  def stats
    @event = Event.now
  end

  private
  
  def logged_in?
    
    if cookies[:crew]
      oneclick = Oneclick.find_by_token(cookies[:crew])
      @user = Attendee.find(oneclick.attendee_id)
      
      unless @user.is_crew_today?
        redirect_to root_path
      end
      
    else
        redirect_to checkin_login_path
    end

  end

end