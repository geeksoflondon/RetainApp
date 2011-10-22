class OnsiteController < ApplicationController

  before_filter :require_admin

  def index
    @event = Event.now
  end

  def create
    attendee_id = params['attendee']

    if attendee_id
      attendee = Attendee.find(attendee_id)
    else
      search_term = params[:onsite]['search']

      if search_term.to_i !=0 && search_term.length == 19
        attendee = Attendee.find_by_barcode(search_term)
      elsif search_term.to_i !=0 && search_term.length == 8
        attendee = Attendee.find(search_term.sub(/^[0]*/,""))
      elsif search_term != ''
        @attendees = Attendee.where("first_name LIKE ?", "%"+search_term+"%")
      end
    end

    if attendee.nil? & @attendees.nil?
      flash[:notice] = "Sorry your search returned no results"
      redirect_to onsite_index_path
    end

    if !@attendees.nil?
      if @attendees.count <= 0
        flash[:notice] = "Sorry your search returned no results"
        redirect_to onsite_index_path
      end
    end

    if attendee
      attendee.scanned!
      flash[:notice] = "#{attendee.first_name} #{attendee.last_name} has been #{attendee.checkin.action_flash}"
      redirect_to onsite_index_path
    end

  end

  def show
    @event = Event.find(params[:id])
    @checkins = Checkin.where('event_id = ?', params[:id])
  end

  def stats
    @event = Event.now
    @checkins = Checkin.where('event_id = ?', params[:id])
  end
end
