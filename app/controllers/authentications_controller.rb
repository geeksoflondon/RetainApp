class AuthenticationsController < ApplicationController
  def new
    @authentications = current_user.authentications if current_user
  end

  def create
    omni_auth = request.env["omniauth.auth"]
    auth = {'provider' => 'twitter', 'uid' => "#{omni_auth['uid']}", 'nickname' => omni_auth['user_info']['nickname']}

    current_user = User.find_or_create_by_omniauth(auth)
    cookies.permanent[:auth_token] = current_user.auth_token unless current_user.nil?
    target = root_url
    unless session[:redirect].nil?
      target = session[:redirect]
      session.delete :redirect
    end
    redirect_to target, :notice => "Welcome!"
  end

  def oneclick
    @onetime = Oneclick.find_by_token_and_used(params[:token], false)
    unless @onetime
      redirect_to root_url, :notice => "Sorry that was an invalid token"
    else
      auth = {'provider' => 'oneclick', 'uid' => "#{@onetime.attendee_id}", 'nickname' => @onetime.nickname}
      current_user = User.find_or_create_by_omniauth(auth)
      cookies.permanent[:auth_token] = current_user.auth_token unless current_user.nil?
      cookies.permanent[:oneclick] = true
      redirect_to '/selfservice/hello'
    end
  end

  def crew
    @event = Event.current.last
  end

  def crew_auth
    @crew = Attendee.find(params[:attendee]['id'].sub(/^[0]*/,""))
    unless @crew.is_crew_today?
      redirect_to root_url, :notice => "Sorry that was an invalid token"
    else
      auth = {'provider' => 'crew', 'uid' => "#{@crew.id}", 'nickname' => "#{@crew.first_name} #{@crew.last_name}"}
      current_user = User.find_or_create_by_omniauth(auth)
      current_user.update_attribute('is_admin', true)
      cookies.permanent[:auth_token] = current_user.auth_token unless current_user.nil?
      cookies.permanent[:crew] = true
      redirect_to '/'
    end
  end

  def setup
    request.env['omniauth.strategy'].consumer_key = ENV['TWITTER_KEY']
    request.env['omniauth.strategy'].consumer_secret = ENV['TWITTER_SECRET']
    render :text => "Setup complete.", :status => 404
  end

  def destroy
    cookies.delete(:auth_token)
    cookies.delete(:oneclick)
    redirect_to root_url, :notice => "Bye, bye!"
  end
end