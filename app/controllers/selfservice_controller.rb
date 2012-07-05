class SelfserviceController < ApplicationController

  before_filter :load_common, :except => [:oneclick, :destroy]

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

  def oneclick
    onetime = Oneclick.find_by_token(params[:token])
    unless onetime
      redirect_to root_url
    else
      cookies.permanent[:token] = onetime.token
      cookies.permanent[:oneclick] = true
      redirect_to '/selfservice/hello'
    end
  end

  def destroy
    cookies.delete(:token)
    cookies.delete(:oneclick)
    cookies.delete(:crew)
    redirect_to root_url
  end

  private

  def load_common
    if cookies[:token]
      oneclick = Oneclick.find_by_token(cookies[:token])
      @attendee = Attendee.find(oneclick.attendee_id)
      @event = @attendee.event
    else
        redirect_to root_url
    end
  end

end