namespace :retain do
  desc "Make a user an admin"
  task :fixcheckins => :environment do |t, args|

    Checkin.all.each do |checkin|
      a = Attendee.find(checkin.attendee_id)
      a.badged = true
      a.onsite = false
      a.save
    end

    Attendee.all.each do |attendee|
      if attendee.status == 'attended'
        attendee.status = 'confirmed'
        attendee.badged = true
        attendee.save
      end
    end

  end

end