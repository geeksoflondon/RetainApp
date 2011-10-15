require "prawn/measurement_extensions"
require "barby/barcode/code_128"
require "barby/outputter/prawn_outputter"
Mime::Type.register "application/pdf", :pdf

class BadgesController < ApplicationController

  before_filter :require_admin

  def individual
    @attendee = Attendee.find(params[:id])
    @barcode = Barby::Code128.new(@attendee.id.to_s.rjust(8, '0'), 'A')
  end

  def event
    @event = Event.find(params[:id])
    @attendees = Attendee.where("event_id = ? AND status != 'cancelled' AND badge != 'crew'", @event.id)
    @crew = Attendee.where("event_id = ? AND status != 'cancelled' AND badge = 'crew'", @event.id)
  end

end
