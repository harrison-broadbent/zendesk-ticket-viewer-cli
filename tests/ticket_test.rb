require 'minitest/autorun'
require 'zendesk_api'
require_relative '../src/Tickets/ticket'

API_URL = 'https://harrison-development.zendesk.com/api/v2'

class TicketTest < MiniTest::Test
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

  def test_ticket_initializes
    ticket = Ticket.new(@sample_ticket)
    ticket.instance_variables.sort.zip(@ticket_data.keys.sort).each do |instance_variable, key|
      assert_equal ticket.instance_variable_get(instance_variable), @ticket_data[key]
    end
  end

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