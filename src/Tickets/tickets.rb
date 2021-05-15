require 'zendesk_api'
require_relative "./ticket.rb"

class Tickets

  def initialize(url, username, api_token)    
    @client = ZendeskAPI::Client.new do |config| 
    
      config.url = url
      config.username = username
      config.token = api_token
    end

  end

  def get_all()
    tickets = []
    @client.tickets.all! do |ticket| 
      tickets.append(Ticket.new(ticket))
    end

    tickets
  end

  def get_single(ticket_id)

    begin
      ticketData = @client.tickets.find!(:id => ticket_id)
      return Ticket.new(ticketData)
    rescue ZendeskAPI::Error::RecordNotFound
      puts
      puts "An error has occured." 
      puts "Could not find a ticket with that ID."
      puts "Please try again with a valid ID."
      puts "You may want to try viewing all tickets to see their associated IDs. "
      puts
    end
  end

end