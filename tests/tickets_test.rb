require 'minitest/autorun'
require_relative '../src/Tickets/ticket'
require_relative '../src/Tickets/tickets'

# API_URL, API_USERNAME, API_TOKEN loaded in via rakefile

class TicketsTest < MiniTest::Test
  def initialize(name)
    super
    @tickets = Tickets.new(API_URL, API_USERNAME, API_TOKEN)
  end

  def test_get_single_ticket
    ticket = @tickets.get_single(2)
    assert_instance_of Ticket, ticket
  end

  def test_get_test_ticket
    ticket = @tickets.get_test_ticket
    assert_instance_of Ticket, ticket
  end

  def test_get_ticket_page
    page_number = 1
    per_page = 2
    tickets = @tickets.get_page(page_number, per_page)

    assert_instance_of Array, tickets
    refute_empty tickets
    assert_instance_of Ticket, tickets.first
  end
end
