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

  def get_page(page_number, per_page)
    tickets = []
    @client.tickets.page(page_number).per_page(per_page).fetch!.each do |ticket|
      tickets.append(Ticket.new(ticket))
    end

    tickets
  end

  def get_single(ticket_id)
    ticketData = @client.tickets.find!(:id => ticket_id)
    return Ticket.new(ticketData)
  end

end