class CheckinController < ApplicationController

  before_filter :logged_in?, :except => [:login, :qrlogin, :app]
  protect_from_forgery :except => :app

  def index
    @event = Event.now
  end

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
      user = Oneclick.find_by_token(params[:token]).attendee
      if user.is_crew_today?
        cookies.permanent[:crew] = user.oneclick.token
      end
    end

    redirect_to checkin_path
  end

  def scanner
    if params[:badge]
      @attendee = Attendee.find(params[:badge].sub(/^[0]*/,""))
      if (@attendee.event_id == Event.now.id)
        @attendee.checkin
        @attendee.reload
      else
        @attendee = nil
        @message = 'Not Found'
      end
    end
  end

  def app
    token = params[:token]
    if token
      oneclick = Oneclick.find_by_token(token)

        if (oneclick == nil || (oneclick.attendee.event_id != Event.now.id))
          response = {:message => "No ticket for event!", :success => false}
        else

          oneclick.attendee.checkin
          oneclick.attendee.reload

          unless (oneclick.attendee.notes && oneclick.attendee.badged == false)
            if oneclick.attendee.onsite == false
              response = {:message => oneclick.attendee.first_name+" checked in", :success => true}
            else
              response = {:message => oneclick.attendee.first_name+" checked out", :success => true}
            end
          else
              response = {:message => "Opening Retain", :success => false, :action_url => 'http://retain.geeksoflondon.com/checkin/issue/'+oneclick.attendee.id}
          end
      end

    else
      response = {:message => "Bad token!", :success => false}

    end

    render :json => response.to_json
  end

  def attendees
    @attendees = Event.now.attendees.where('status != ?', 'cancelled')
  end

  def attendee
    @attendee = Attendee.find(params[:id])
  end

  def issue
    @attendee = Attendee.find(params[:id])
  end

  def stats
    @event = Event.now
  end

  private

  def logged_in?

    if cookies[:crew]
      oneclick = Oneclick.find_by_token(cookies[:crew])
      unless oneclick.attendee.is_crew_today?
        redirect_to checkin_login_path
      end

    else
        redirect_to checkin_login_path
    end

    @user = oneclick.attendee
  end

end