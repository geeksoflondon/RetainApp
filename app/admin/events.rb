ActiveAdmin.register Event do
  filter :name

  index do
    column :name
    column :start
    column :end

    column "SignUps" do |event|
      event.signups
    end

    column "Unconfirmed" do |event|
      event.unconfirmed
    end

    column "Confirmed" do |event|
      event.confirmed
    end

    column "Cancelled" do |event|
      event.cancelled
    end


    column "Attending" do |event|
      event.attending
    end

    column "Attended" do |event|
      event.attended
    end


    column "Actions" do |event|
        link_to "View", admin_event_path(event)
    end
  end

  # show :title => :name do
  # end

  sidebar :counts, :only => :show do
    dl do
      dt "Signups"
      dd event.signups

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
