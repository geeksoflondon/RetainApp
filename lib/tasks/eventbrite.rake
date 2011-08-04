require 'json'
require 'net/http'

BADGE_TYPES = {
  'attendee' => 'Attendee',
  'crew' => 'Crew',
  'sponsor' => 'Sponsor',
  'venue_staff' => 'Venue Staff'
}.freeze

USER_KEY = ENV['EVENTBRITE_USERKEY']
API_KEY = ENV['EVENTBRITE_APIKEY']

namespace :eventbrite do
  desc "Make a user an admin"
  task :import_attendees, [:retain_id] => :environment do |t, args|

    @retain_id = args.retain_id.to_i
    @event_id = args.event_id.to_i

    @event = Event.find(@retain_id)
    @event_id = @event.eventbrite_id.to_i

    unless @retain_id.zero? && @event_id.zero?

      tickets = get_tickets(@event_id)
      event_attendees = get_attendees(@event_id)

      clean_attendees = Array.new

      event_attendees['attendees'].each do |inbound_attendee|
        ai = process_answers(inbound_attendee['attendee']['answers'])
        ai['ticket_id'] = inbound_attendee['attendee']['id']
        ai['first_name'] = inbound_attendee['attendee']['first_name']
        ai['last_name'] = inbound_attendee['attendee']['last_name']
        ai['email'] = inbound_attendee['attendee']['email']
        ai['badge'] = sort_badge(tickets[inbound_attendee['attendee']['ticket_id']])
        clean_attendees.push(ai)
      end

      clean_attendees.each do |row|
        attendee = {}
        attendee = Attendee.where('ticket_id' => row["ticket_id"], 'event_id' => @retain_id, )
        unless attendee.exists?
          row["event_id"] = @retain_id
          imported_attendee = Attendee.new(row)
          imported_attendee.save!
          puts "#{row['first_name']} #{row['last_name']} was created"
        else
          attendee = Attendee.find(attendee.first['id'])
          unless attendee.status == 'confirmed'
            attendee.update_attributes!(row)
            puts "#{row['first_name']} #{row['last_name']} was updated"
          else
            puts "#{row['first_name']} #{row['last_name']} was not updated as confirmed"
          end
        end

      end

    else

      puts "You did enter all arguments"

    end

  end
end

def get_tickets(event_id)
   base_url = "http://www.eventbrite.com/json/event_get?app_key=#{API_KEY}&user_key=#{USER_KEY}"
   url = "#{base_url}&id=#{event_id}"
   resp = Net::HTTP.get_response(URI.parse(url))
   data = resp.body

   result = JSON.parse(data)

   tickets = {}

   if result.has_key? 'Error'
      raise "web service error"
   else
     result['event']['tickets'].each do |ticket|
       id = ticket['ticket']['id']
       badge = ticket['ticket']['name']
       tickets[id] = badge
     end
   end
   return tickets
end

def get_attendees(event_id)
   base_url = "http://www.eventbrite.com/json/event_list_attendees?app_key=#{API_KEY}&user_key=#{USER_KEY}"
   url = "#{base_url}&id=#{event_id}&count=9999"
   resp = Net::HTTP.get_response(URI.parse(url))
   data = resp.body

   result = JSON.parse(data)

   if result.has_key? 'Error'
      raise "web service error"
   end
   return result
end

def process_answers(dirty_answers)

  clean_answers = {}

  dirty_answers.each do |answer|

    aq = answer['answer']['question']
    at = answer['answer']['answer_text']

    if aq == 'Twitter Username'
      clean_answers['twitter'] = at
    elsif aq == 'A contact number'
      clean_answers['phone_number'] = at
    elsif aq == 'T-Shirt Size'
      clean_answers['t_shirt'] = at
    elsif aq == 'Dietary Requirements'
      clean_answers['diet'] = at
    end
  end

  return clean_answers

end

def sort_badge(badge_name)
  unless BADGE_TYPES.has_value?(badge_name)
    return 'Attendee'
  end

  return badge_name
end