require "barby/barcode/code_128"

class QjumpController < ApplicationController

  def index
    cookies.delete(:token)
    cookies.delete(:oneclick)
    @oneclick = Oneclick.find_by_token(params[:token])
    @attendee = @oneclick.attendee
    @event = @attendee.event
  end

  def barcode
    oneclick = Oneclick.find_by_token(params[:token])
    redirect_to "http://chart.apis.google.com/chart?cht=qr&chs=230x230&chld=L&choe=UTF-8&chl=http%3A%2F%2Fme.geeksoflondon.com%2Fbadge%2F"+oneclick.token
  end


end