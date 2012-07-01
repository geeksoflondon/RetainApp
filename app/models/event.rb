require 'carrierwave/orm/activerecord'

class Event < ActiveRecord::Base
  validates_presence_of :name, :event_url, :start, :end, :venue
  has_many :attendees, :dependent => :destroy

  validates_format_of :event_url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  validates_format_of :venue_url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix, :allow_blank => true

  mount_uploader :logo, EventLogoUploader

  def self.current
    Event.where('start <= ?', Time.now + 14.days).find(:all)
  end

  def self.now
    event = Event.where('start => ? AND end <= ?', Time.now, Time.now)
    unless event.nil?
      event = Event.where('start > ?', Time.now).first
    end
  end

  def english_date
    event_length = (self.end - self.start).to_i
    unless event_length > 0
      "on #{self.start.to_formatted_s(:long_ordinal)}"
    else
      "from #{self.start.to_formatted_s(:long_ordinal)} to #{self.end.to_formatted_s(:long_ordinal)}"
    end
  end

  def signups
    Attendee.where('event_id = ?', self.id).count
  end

  def confirmed
    Attendee.where('event_id = ? AND status LIKE ?', self.id, 'confirmed').count
  end

  def unconfirmed
    Attendee.where('event_id = ? AND status LIKE ?', self.id, 'unconfirmed').count
  end

  def cancelled
    Attendee.where('event_id = ? AND status LIKE ?', self.id, 'cancelled').count
  end

  def attending
    self.signups - self.unconfirmed - self.cancelled
  end

  def attended
    return Attendee.where('event_id = ? AND badged = ?', self.id, true).count
    if Time.now.to_date < self.start
      return 'N/A'
    else
      return Attendee.where('event_id = ? AND badged = ?', self.id, true).count
    end
  end

  def no_show
    return (Attendee.where('event_id = ? AND badged = ?', self.id, false).count - self.cancelled)
  end

  def attended_conf
    Attendee.where('event_id = ? AND status LIKE ? AND badged = ?', self.id, 'confirmed', true).count
  end

  def attended_unconf
    Attendee.where('event_id = ? AND status LIKE ? AND badged = ?', self.id, 'unconfirmed', true).count
  end

  def noshow_conf
    Attendee.where('event_id = ? AND status LIKE ? AND badged = ?', self.id, 'confirmed', false).count
  end

  def noshow_unconf
    Attendee.where('event_id = ? AND status LIKE ? AND badged = ?', self.id, 'unconfirmed', false).count
  end

  def onsite
    Attendee.where('event_id = ? AND onsite = ?', self.id, true).count
  end

  def offsite
    return (self.attended - self.onsite)
  end
end
