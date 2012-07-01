class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :redirect_one_click

  private

  def display_notice?
    if flash[:notice] || flash[:errors]
      return true
    end
  end

  def redirect_one_click
    if cookies['oneclick'] && params[:controller] != 'selfservice'
        if params[:controller] != 'authentications' && params[:method] != 'destroy'
          redirect_to selfservice_url
        end
    end
  end

end
