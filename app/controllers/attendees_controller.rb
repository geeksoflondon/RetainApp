class AttendeesController < ApplicationController
  
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
      redirect_to @attendee, :notice => 'Attendee was successfully created.'
    else
      render :action => "new"
    end
  end

  # PUT /attendees/1
  def update
    @attendee = Attendee.find(params[:id])

    if @attendee.update_attributes(params[:attendee])
      redirect_to @attendee, :notice => 'Attendee was successfully updated.'
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
end
