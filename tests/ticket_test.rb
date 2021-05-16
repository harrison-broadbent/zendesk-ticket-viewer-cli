# frozen_string_literal: true

require 'minitest/autorun'
require 'zendesk_api'
require_relative '../src/Tickets/ticket'

# API_URL, API_USERNAME, API_TOKEN loaded in via rakefile.

# Tests for the Ticket class.
#
# Tests:
# - Ticket#initialize properly initializes and contains relevant info.
# - Ticket#display displays as expected.
class TicketTest < MiniTest::Test

  # Initialize the test with some mock data..
  #
  # We only pass in the API_URL to the client config
  # as we dont use it to make requests, just to create a sample ticket.
  def initialize(name)
    super
    @ticket_data = {
      id: 2,
      requester_id: 902131179606,
      assignee_id: 902131179606,
      tags: %w[tag1 tag2 tag3],
      subject: 'This is the ticket subject',
      description: 'This is the longer description of the ticket. As you can see, it has some length to it.'
    }

    @client = ZendeskAPI::Client.new do |config|
      config.url = API_URL
    end

    @sample_ticket = ZendeskAPI::Ticket.new(@client, @ticket_data)
  end

  # Test to ensure that a Ticket has the same data as a ZendeskAPI::Ticket
  # when initialized from the same source.
  def test_ticket_initializes
    ticket = Ticket.new(@sample_ticket)
    ticket.instance_variables.sort.zip(@ticket_data.keys.sort).each do |instance_variable, key|
      assert_equal ticket.instance_variable_get(instance_variable), @ticket_data[key]
    end
  end

  # Test that a ticket displays the way we expect it to.
  # Added after I noticed that the ticket description was not displaying properly.
  def test_ticket_displays
    ticket = Ticket.new(@sample_ticket)
    assert_output(/
      +--------------+-------------------------------------------------------------------+
      | Ticket ID    | 2                                                                 |
      | Requester ID | 902131179606                                                      |
      | Assignee ID  | 902131179606                                                      |
      | Tags         | ["tag1", "tag2", "tag3"]                                          |
      | Subject      | This is the ticket subject                                        |
      | Description  | This is the longer description of the ticket. As you can see, it  |
      |              | has some length to it.                                            |
      +--------------+-------------------------------------------------------------------+
      /) { ticket.display }
  end
end
