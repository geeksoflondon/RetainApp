class Tracking < ActiveRecord::Base
  belongs_to :attendee
  
  validates_presence_of :event_id, :attendee_id, :action
  
end