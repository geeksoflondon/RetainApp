require "barby/barcode/code_128"

class QjumpController < ApplicationController

  def index
    @oneclick = Oneclick.find_by_token(params[:token])
    @attendee = @oneclick.attendee
    @event = @attendee.event
  end

  def barcode
    oneclick = Oneclick.find_by_token(params[:token])
    redirect_to "http://www.barcodesinc.com/generator/image.php?code="+oneclick.attendee_id.to_s.rjust(8, '0')+"&style=197&type=C128B&width=450&height=100&xres=2&font=3"
  end


end