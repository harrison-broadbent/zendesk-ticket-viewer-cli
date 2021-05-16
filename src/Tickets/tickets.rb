# frozen_string_literal: true

require 'zendesk_api'
require_relative './ticket'

class Tickets

  def initialize(url, username, api_token)
    @client = ZendeskAPI::Client.new do |config|
      config.url = url
      config.username = username
      config.token = api_token
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
      puts 'An error has occurred.'
      puts 'Record not found.'
    rescue ZendeskAPI::Error::NetworkError
      puts 'An error has occurred.'
      puts 'API is unavailable. Check your network and https://status.zendesk.com .'
    rescue StandardError => e
      puts 'An error has occurred.'
      puts e.to_s
    end
  end

  def get_single(ticket_id)
    begin
      ticket_data = @client.tickets.find!(id: ticket_id)
      Ticket.new(ticket_data)
    rescue ZendeskAPI::Error::RecordNotFound
      puts 'An error has occurred.'
      puts 'Record not found.'
    rescue ZendeskAPI::Error::NetworkError
      puts 'An error has occurred.'
      puts 'API is unavailable. Check your network and https://status.zendesk.com .'
    rescue StandardError => e
      puts 'An error has occurred.'
      puts e.to_s
    end
  end

  def get_test_ticket
    ticket_data = @client.tickets.first
    Ticket.new(ticket_data)
  end

end
