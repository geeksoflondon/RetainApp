require "digest"

class Oneclick < ActiveRecord::Base
  after_initialize :init
  
  validates_presence_of :attendee_id
  
  belongs_to :attendee
  
  def init
    self.used ||= 0
    self.token = Digest::SHA1.hexdigest("#{rand(1000000) * rand(999999) * rand(77777777) / rand(1846324)}#{Time.now()}").freeze
  end
    
end
