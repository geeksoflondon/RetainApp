ActiveAdmin.register Attendee do

  filter :first_name
  filter :last_name
  filter :phone_number
  filter :event
  filter :status, :as => :select, :collection => proc { Attendee.status_types.invert }
  filter :badge, :as => :select, :collection => proc { Attendee.badge_types.invert }
  filter :badged, :as => :select, :collection => proc {{'Yes' => true, 'No' => false}}

  index do

    column :id
    column :first_name
    column :last_name

    column "Badge" do |attendee|
      attendee.badge_types[attendee.badge]
    end

    column :email
    column :phone_number

    column "Status" do |attendee|
      attendee.status_types[attendee.status]
    end

    column "Badged" do |attendee|
      if attendee.badged == true
        "Yes"
      else
        "No"
      end
    end

    column "View" do |attendee|
        link_to "View", admin_attendee_path(attendee)
    end

    column "Badge" do |attendee|
      link_to "Badge", "/badge/attendee/#{attendee.id}.pdf"
    end

  end

  sidebar "Current Event", :only => :index do
    event = Event.now

    h4 event.name

    dl do
      dt "Signups"
      dd event.signups

      dt "Unconfirmed"
      dd event.unconfirmed

      dt "Confirmed"
      dd event.confirmed

      dt "Cancelled"
      dd event.cancelled

      dt "Attending"
      dd event.attending

      dt "Attended"
      dd event.attended

      dt "Attended + Confirmed"
      dd event.attended_conf

      dt "Attended + Unconfirmed"
      dd event.attended_unconf

      dt "No Show"
      dd event.no_show

      dt "No Show + Confirmed"
      dd event.noshow_conf

      dt "No Show + Unconfirmed"
      dd event.noshow_unconf

      dt "Onsite"
      dd event.onsite

      dt "Offsite"
      dd event.offsite
    end
  end

end