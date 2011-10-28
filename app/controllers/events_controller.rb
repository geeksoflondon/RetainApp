class EventsController < ApplicationController

  before_filter :require_admin

  # GET /events
  def index
    @events = Event.all
  end

  # GET /events/1
  def show
    @event = Event.find(params[:id])

    unless params[:filter]
      @attendees = Attendee.where('event_id' => params[:id])
    else
      if params[:filter_type] == 'status_type'
        @attendees = Attendee.where('event_id' => params[:id], 'status' => params[:filter])
      elsif params[:filter_type] == 'badge_type'
        @attendees = Attendee.where('event_id' => params[:id], 'badge' => params[:filter])
      elsif params[:filter_type] == 'attendance_type'
        if params[:filter] == 'shows'
          @attendees = Attendee.where('event_id' => params[:id]).select{|attendee| attendee.checkin.attended == true }
        elsif params[:filter] == 'noshows'
          @attendees = Attendee.where('event_id' => params[:id]).select{|attendee| attendee.checkin.attended == false && attendee.status != 'cancelled'}
        elsif params[:filter] == 'shows_conf'
          @attendees = Attendee.where('event_id' => params[:id], 'status' => 'confirmed').select{|attendee| attendee.checkin.attended == true }
        elsif params[:filter] == 'shows_unconf'  
          @attendees = Attendee.where('event_id' => params[:id], 'status' => 'unconfirmed').select{|attendee| attendee.checkin.attended == true }
        elsif params[:filter] == 'noshows_conf'
          @attendees = Attendee.where('event_id' => params[:id], 'status' => 'confirmed').select{|attendee| attendee.checkin.attended == false && attendee.status != 'cancelled' }
        elsif params[:filter] == 'noshows_unconf'  
          @attendees = Attendee.where('event_id' => params[:id], 'status' => 'unconfirmed').select{|attendee| attendee.checkin.attended == false && attendee.status != 'cancelled'}

        end
      end
    end

    respond_to do |format|
      format.html
      format.csv { render :template => 'events/csv' }
    end

  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to @event, :notice => 'Event was successfully created.'
    else
      render :action => "new"
    end
  end

  # PUT /events/1
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
        redirect_to @event, :notice => 'Event was successfully updated.'
    else
        render :action => "edit"
    end
  end

  # DELETE /events/1
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url
  end

end
