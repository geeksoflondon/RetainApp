ActiveAdmin.register Attendee do

  filter :first_name
  filter :last_name
  filter :event
  filter :status, :as => :select, :collection => proc { options_from_collection_for_select(Attendee.status_types.sort) }
  filter :badge, :as => :select, :collection => proc { options_from_collection_for_select(Attendee.badge_types.sort) }
  filter :attended

  index do

    column :id
    column :first_name
    column :last_name
    column :badge
    column :email
    column :phone_number
    column :status
    column :badged

    column "Actions" do |attendee|
        link_to "View", admin_attendee_path(attendee)
        link_to "Badge"
    end

  end
end