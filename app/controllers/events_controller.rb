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
      @attendees = Attendee.where('event_id' => params[:id], 'status' => params[:filter])
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

  def onenight
    
    @attendees = Array.new
    
    offsite = Checkin.where('onsite = ?', false)
    offsite.each do |checkin|
      if checkin.attendee.status == 'attended'
        @attendees << checkin.attendee
      end
    end
    
    respond_to do |format|
      format.csv { render :template => 'events/csv' }
    end
    
  end

end
