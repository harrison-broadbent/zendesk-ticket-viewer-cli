# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../src/Tickets/ticket'
require_relative '../src/Tickets/tickets'

# API_URL, API_USERNAME, API_TOKEN loaded in via rakefile.

# Tests for the Tickets class.
# Tests rely on the Zendesk API being available so that we can fetch tickets.

# Tests:
# - Tickets#get_single returns a Ticket.
# - Tickets#get_test_ticket returns a Ticket.
# - Tickets#get_page returns an array of Ticket instances.
class TicketsTest < MiniTest::Test

  def initialize(name)
    super
    @tickets = Tickets.new(API_URL, API_USERNAME, API_TOKEN)
  end

  # Tests that we can get a single ticket,
  # and that the returned ticket is an instance of Ticket.

  # We get a ticket directly by it's ID -
  # if this ticket is removed, then this test will fail.
  def test_get_single_ticket
    ticket = @tickets.get_single(2)
    assert_instance_of Ticket, ticket
  end

  # Tests that we can get a test ticket (ie. the first ticket) from the API.
  #
  # This is used when the application starts to check whether we can
  # make a connection to the API.
  def test_get_test_ticket
    ticket = @tickets.get_test_ticket
    assert_instance_of Ticket, ticket
  end

  # Tests whether we can get a page of tickets,
  # using the available method in the Tickets class.
  def test_get_ticket_page
    page_number = 1
    per_page = 2
    tickets = @tickets.get_page(page_number, per_page)

    assert_instance_of Array, tickets
    refute_empty tickets
    assert_instance_of Ticket, tickets.first
  end
end
