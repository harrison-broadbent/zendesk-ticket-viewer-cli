# frozen_string_literal: true

require 'zendesk_api'
require_relative './ticket'

# Class to interact with the Zendesk API via the zendesk_api gem
# and return single/groups of Ticket instances.
#
# Tickets#get_page and Tickets#get_single handle errors themselves, and display relevant messages to the terminal.
# Tickets#get_test_ticket does not handle it's own errors, so that they can be raised and dealt with.
#
# Tickets(url: string, username: string, api_token: string)
# METHODS:
# - Tickets#get_page(page_number: integer, per_page: integer) : Array[Ticket]
# - Tickets#get_single(ticket_id: integer) : Ticket
# - Tickets#get_test_ticket : Ticket
class Tickets

  # initialize a local instance of a ZendeskAPI::Client to make requests with.
  #
  # INPUT:
  # url:        string
  # username:   string
  # api_token:  string
  def initialize(url, username, api_token)
    @client = ZendeskAPI::Client.new do |config|
      config.url = url
      config.username = username
      config.token = api_token
    end
  end

  # Gets a page of tickets using the builtin pagination from the zendesk_api gem.
  # a 'page' from the zendesk_api gem is simply a collection of tickets of length (total_number_of_tickets / per_page),
  # offset at page_number*per_page.
  #
  # INPUT:
  # page_number : integer
  # per_page    : integer
  #
  # RETURN:
  # Array[Ticket] if no error is raised.
  # OR
  # nil if an error is raised.
  def get_page(page_number, per_page)
    begin
      tickets = []
      @client.tickets.page(page_number).per_page(per_page).fetch!.each do |ticket|
        tickets.append(Ticket.new(ticket))
      end
      tickets
    rescue ZendeskAPI::Error::RecordNotFound
      # raised if there are no tickets,
      # either because the user has no tickets,
      # or because the API is not returning any tickets
      puts 'An error has occurred.'
      puts 'Record not found.'
    rescue ZendeskAPI::Error::NetworkError
      # raised if the @client instance cannot connect to the API
      puts 'An error has occurred.'
      puts 'API is unavailable. Check your network and https://status.zendesk.com .'
    rescue StandardError => e
      # generic catch-all for other errors
      puts 'An error has occurred.'
      puts e.to_s
    end
  end

  # Gets a single ticket by its ID
  #
  # INPUT:
  # ticket_id : integer
  #
  # RETURN:
  # Ticket
  def get_single(ticket_id)
    begin
      ticket_data = @client.tickets.find!(id: ticket_id)
      Ticket.new(ticket_data)
    rescue ZendeskAPI::Error::RecordNotFound
      # raised if there are no tickets,
      # either because the user has no tickets,
      # or because the API is not returning any tickets
      puts 'An error has occurred.'
      puts 'Record not found.'
    rescue ZendeskAPI::Error::NetworkError
      # raised if the @client instance cannot connect to the API
      puts 'An error has occurred.'
      puts 'API is unavailable. Check your network and https://status.zendesk.com .'
    rescue StandardError => e
      # generic catch-all for other errors
      puts 'An error has occurred.'
      puts e.to_s
    end
  end

  # Used to check whether the Zendesk API is available.
  # Other methods in Tickets handle errors themselves, but that is avoided here
  # so that any errors get surfaced to the part of the application that calls this method.
  #
  # INPUT:
  # none
  #
  # RETURN:
  # Ticket
  def get_test_ticket
    ticket_data = @client.tickets.first
    Ticket.new(ticket_data)
  end

end
