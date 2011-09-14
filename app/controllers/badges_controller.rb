require "prawn/measurement_extensions"
require "barby/barcode/code_128"
require "barby/outputter/prawn_outputter"
Mime::Type.register "application/pdf", :pdf

class BadgesController < ApplicationController

  before_filter :require_admin

  def individual
    @attendee = Attendee.find(params[:id])
    @barcode = Barby::Code128.new("00000000", 'A')
  end

  def event
    @event = Event.find(params[:id])
    @barcode = Barby::Code128.new("00000000", 'A')
    @attendees = Attendee.where("event_id = ? AND status != 'cancelled'", @event.id)
  end

end
