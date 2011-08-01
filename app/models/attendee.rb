class Attendee < ActiveRecord::Base

  #Frozen Options
  VALID_STATUS = { 
    'unconfirmed' => 'Unconfirmed',
    'confirmed' => 'Confirmed',
    'attended' => 'Attended',
    'cancelled' => 'Cancelled'
  }.freeze

  VALID_BADGES = {
    'attendee' => 'Attendee',
    'crew' => 'Crew',
    'sponsor' => 'Sponsor',
    'venue_staff' => 'Venue Staff'
  }.freeze

  VALID_DIETS = {
    'everything' => 'Everything',
    'veggie' => 'Vegetarian',
    'vegan' => 'Vegan',
    'nuts' => 'Nut Allergy',
    'lactose' => 'Lactose Free',
    'gluten' => 'Gluten Free',
    'shellfish' => 'Shellfish',
    'other' => 'Other'
  }.freeze

  VALID_TSHIRTS = {
    'f1' => 'Female Small',
    'f2' => 'Female Medium',
    'f3' => 'Female Large',
    'm1' => 'Male Small',
    'm2' => 'Male Medium',
    'm3' => 'Male Large',
    'm4' => 'Male Extra Large',
    'm5' => 'Male XXL'
  }.freeze

  #Relationships
  belongs_to :event
  has_one :oneclick, :dependent => :destroy

  #At Events
  after_initialize :init
  before_validation :translate
  #before_validation :clean_up
  after_save :generate_oneclick

  #Validators
  validates_presence_of :event_id, :status
  validates_presence_of :first_name, :last_name, :t_shirt, :diet, :badge
  validates :email, :presence => true,
                    :length => {:minimum => 3, :maximum => 254},
                    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}

  validates_inclusion_of :status, :in => VALID_STATUS,
      :message => "%{value} is not a valid status"

  validates_inclusion_of :badge, :in => VALID_BADGES,
      :message => "%{value} is not a valid badge type"

  validates_inclusion_of :t_shirt, :in => VALID_TSHIRTS,
      :message => "%{value} is not a valid T-Shirt size"

  validates_inclusion_of :diet, :in => VALID_DIETS,
      :message => "%{value} is not a valid diet"

  #These are the defaults when nothing else is set
  def init
    self.badge  ||= 'attendee'
    self.status ||= 'unconfirmed'
    self.t_shirt ||= 'm2'
    self.diet ||= 'everything'
  end

  #These are methods to translate values
  def status_types
    @status_types = VALID_STATUS
  end

  def badge_types
    @badge_types = VALID_BADGES
  end

  def diet_types
    @diet_types = VALID_DIETS
  end

  def tshirt_types
    @tshirt_types = VALID_TSHIRTS
  end

  def translate
    if VALID_BADGES.has_value?(self.badge)
      self.badge = VALID_BADGES.key(self.badge)
    end

    if VALID_TSHIRTS.has_value?(self.t_shirt)
      self.t_shirt = VALID_TSHIRTS.key(self.t_shirt)
    end

    if VALID_DIETS.has_value?(self.diet)
      self.diet = VALID_DIETS.key(self.diet)
    end
  end

  def clean_up
    unless self.twitter.empty?
      if self.twitter.start_with?('@')
        self.twitter = self.twitter.strip.gsub(/@/, "")
      end
    end
  end

  def generate_oneclick
    unless Oneclick.find_by_attendee_id(self.id)
      oneclick = Oneclick.new('attendee_id' => self.id)
      oneclick.save
    end
  end

  def transistion_status(to)
    states = VALID_STATUS.collect {|x,y| x}

    to = states.index(to).to_i
    from = states.index(self.status).to_i

    unless from > to
      throw(to) {
        logger.info "Invalid Transistion performed #{from} >. #{to}"
      }
    end

    self.status = states.values(to)
    self.save
  end
end
