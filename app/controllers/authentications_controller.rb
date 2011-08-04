class AuthenticationsController < ApplicationController
  def new
    @authentications = current_user.authentications if current_user
  end

  def create
    omni_auth = request.env["omniauth.auth"]
    auth = {'provider' => 'twitter', 'uid' => omni_auth['uid'], 'nickname' => omni_auth['user_info']['nickname']}

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
      #Lockout and kill the token from future use
      @onetime.lockout

      auth = {'provider' => 'oneclick', 'uid' => @onetime.attendee_id, 'nickname' => @onetime.nickname}
      current_user = User.find_or_create_by_omniauth(auth)
      cookies.permanent[:auth_token] = current_user.auth_token unless current_user.nil?
      redirect_to '/selfservice/hello'
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url, :notice => "Bye, bye!"
  end
end