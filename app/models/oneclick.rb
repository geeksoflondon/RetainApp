require "digest"

class Oneclick < ActiveRecord::Base
  after_initialize :init
  before_create :generate_token

  validates_presence_of :attendee_id

  belongs_to :attendee

  def init
    self.used ||= 0
  end

  def generate_token
      self.token = Digest::SHA1.hexdigest("#{self.attendee_id}#{rand(1000000) * rand(999999) * rand(77777777) / rand(1846324)}#{Time.now()}").freeze
  end

  def nickname
    "#{self.attendee['first_name']} #{self.attendee['last_name']}"
  end

  def lockout
    self.used = true
    self.save
  end

end
