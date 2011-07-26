require 'csv'

class AttendeesController < ApplicationController
  
  before_filter :require_admin
  
  # GET /attendees/1
  def show
    @attendee = Attendee.find(params[:id])
  end

  # GET /attendees/new
  def new
    @attendee = Attendee.new
  end

  # GET /attendees/1/edit
  def edit
    @attendee = Attendee.find(params[:id])
  end

  # POST /attendees
  def create
    @attendee = Attendee.new(params[:attendee])
    
    if @attendee.save
      redirect_to @attendee.event, :notice => 'Attendee was successfully created.'
    else
      render :action => "new"
    end
  end

  # PUT /attendees/1
  def update
    @attendee = Attendee.find(params[:id])

    if @attendee.update_attributes(params[:attendee])
      redirect_to @attendee.event, :notice => 'Attendee was successfully updated.'
    else
      render :action => "edit"
    end
  end

  # DELETE /attendees/1
  def destroy
    @attendee = Attendee.find(params[:id])
    @attendee.destroy
    redirect_to attendees_url
  end
  
  # Bulk Import a CSV of attendees
  def bulkimport
    @event = Event.find(params[:event_id])
    csv_data = params[:file].read
    
    unless params[:file].content_type == 'text/csv'
      redirect_to @event, :notice => 'File was not a valid CSV'
    end
    
    csv_data = CSV.parse(csv_data)
    headers = csv_data.shift.map {|i| i.to_s.downcase }
    rows = csv_data.map {|row| row.map {|cell| cell.to_s } }
    import_data = rows.map {|row| Hash[*headers.zip(row).flatten] }
    
    import_data.each do |row|
      attendee = Attendee.where('ticket_id' => row["ticket_id"], 'event_id' => @event.id)
      unless attendee.exists?
        row["event_id"] = @event.id
        imported_attendee = Attendee.new(row)
        imported_attendee.save!
      else
        attendee = Attendee.find(attendee.first['id'])
        attendee.update_attributes!(row)
      end
      
    end
    
    redirect_to @event, :notice => 'Attendes have been updated'
    
  end
  
  private
  
  
  ###We are not yet using the below may use later.
  VALID_CSV_FIELDS = ['TICKET_ID','FIRST_NAME','LAST_NAME','PHONE','EMAIL','T_SHIRT','BADGE','DIET', 'TWITTER']
  
end