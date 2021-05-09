require 'zendesk_api'
require_relative "./ticket.rb"

class Tickets

  def initialize(url, username, api_token)
    @api_token = api_token
    
    @client = ZendeskAPI::Client.new do |config| 
    
      config.url = url
      config.username = username
      config.token = api_token
    end

  end

  def get_all()
    tickets = []

    @client.tickets.all! do |ticket| 
      tickets += Ticket.new().initializeFromData(ticket)
    end

    tickets
  end

  def get_single(ticket_id)
    ticketData = @client.tickets.find!(:id => ticket_id)
    return Ticket.new().initializeFromData(ticketData)
  end

end