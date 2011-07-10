class Attendee < ActiveRecord::Base
  
  #Frozen Options
  VALID_STATUS = { 
    'unconfirmed' => 'UnConfirmed', 
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
    'm5' => 'Max XXL'
  }.freeze
  
  #Relationships
  belongs_to :event
  
  #Validators
  validates_presence_of :event_id, :status 
  validates_presence_of :first_name, :last_name, :email, :t_shirt, :diet, :badge
  
  validates_inclusion_of :status, :in => VALID_STATUS,
      :message => "%{value} is not a valid status"
  
  validates_inclusion_of :badge, :in => VALID_BADGES,
      :message => "%{value} is not a valid badge type"

  validates_inclusion_of :t_shirt, :in => VALID_TSHIRTS,
      :message => "%{value} is not a valid T-Shirt size"

  validates_inclusion_of :diet, :in => VALID_DIETS,
      :message => "%{value} is not a valid diet"

  #Callbacks
  before_create :generate_ticket_id
  
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
    
end
