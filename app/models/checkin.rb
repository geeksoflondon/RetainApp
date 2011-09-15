class Checkin < ActiveRecord::Base
  belongs_to :attendee
  validates_presence_of :attendee_id

  after_initialize :init

  def init
    self.onsite ||= false
  end

  def scan
    if self.onsite === false
      self.onsite = true
    else
      self.onsite = false
    end
    self.save
  end

  def button
    if self.onsite == true
      return 'Check Out'
    else
      return 'Check In'
    end
  end

  def action_flash
    if self.onsite == true
      return 'Checked In'
    else
      return 'Checked Out'
    end
  end

end