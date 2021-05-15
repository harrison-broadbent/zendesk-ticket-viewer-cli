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
    begin
      tickets = []
      @client.tickets.all! do |ticket| 
        tickets.append(Ticket.new(ticket))
      end
      tickets
    rescue ZendeskAPI::Error::RecordNotFound
      puts "An error has occured."
      puts "Record not found."
    rescue ZendeskAPI::Error::NetworkError
      puts "An error has occured."
      puts "API is unavailable. Check your network and https://status.zendesk.com ."
    rescue => error
      puts "An error has occured."
      puts error.to_s
    end
  end

  def get_page(page_number, per_page)
    begin
      tickets = []
      @client.tickets.page(page_number).per_page(per_page).fetch!.each do |ticket|
        tickets.append(Ticket.new(ticket))
      end
      tickets
    rescue ZendeskAPI::Error::RecordNotFound
      puts "An error has occured."
      puts "Record not found."
    rescue ZendeskAPI::Error::NetworkError
      puts "An error has occured."
      puts "API is unavailable. Check your network and https://status.zendesk.com ."
    rescue => error
      puts "An error has occured."
      puts error.to_s
    end
  end

  def get_single(ticket_id)
    begin
      ticketData = @client.tickets.find!(:id => ticket_id)
      return Ticket.new(ticketData)
    rescue ZendeskAPI::Error::RecordNotFound
      puts "An error has occured."
      puts "Record not found."
    rescue ZendeskAPI::Error::NetworkError
      puts "An error has occured."
      puts "API is unavailable. Check your network and https://status.zendesk.com ."
    rescue => error
      puts "An error has occured."
      puts error.to_s
    end
  end

  def get_test_ticket()
    ticketData = @client.tickets.first
    return Ticket.new(ticketData)
  end

end