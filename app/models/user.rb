class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy

  before_create :generate_token(:auth_token)

  def self.find_or_create_by_omniauth(auth)
    authentication = Authentication.find_or_create_by_provider_and_uid(auth["provider"], auth["uid"])

    if authentication.user.nil?
      user = User.new
      user.name = auth['nickname']
      user.save
      authentication.user = user
      authentication.save
    end

    return authentication.user
  end

  def is_attendee
    one_click = self.authentications.find_by_provider("oneclick")
    unless one_click.nil?
      @attendee = Attendee.find(one_click['uid'])
    end
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end