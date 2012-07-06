require "barby/barcode/code_128"

class QjumpController < ApplicationController

  def index
    @oneclick = Oneclick.find_by_token(params[:token])
    @attendee = @oneclick.attendee
    @event = @attendee.event
  end

  def barcode
    oneclick = Oneclick.find_by_token(params[:token])
    redirect_to "http://qr.kaywa.com/img.php?s=8&d=http%3A%2F%2Fme.geeksoflondon.com%2Fbadge%2F"+oneclick.token
  end


end