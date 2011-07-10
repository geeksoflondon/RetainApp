class Event < ActiveRecord::Base
  validates_presence_of :name, :start, :end, :venue
  has_many :attendees, :dependent => :destroy
end
