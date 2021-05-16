# frozen_string_literal: true

require 'terminal-table'

# Generic class for a Ticket
#
# Ticket is initialized from an instance of ZendeskAPI::Ticket.
# Extracts the relevant data into a class that is easily manipulated
# and adds a method to display tickets to the terminal in a pretty table.
class Ticket

  # Initialize a Ticket with relevant data.
  #
  # INPUT:
  # data: ZendeskAPI::Ticket
  def initialize(data)
    @id           = data.id
    @requester_id = data.requester_id
    @assignee_id  = data.assignee_id
    @subject      = data.subject
    @description  = data.description
    @tags         = data.tags.map(&:id)
  end

  # Displays a Ticket instances data to the terminal.
  # Uses the terminal-table gem to display ticket details in a pretty table
  # with the ticket description line-length limited so that it displays nicer in a terminal.
  # See the example output below.
  def display

    # Terminal::Table takes in a parameter rows,
    # a 2d array defining the rows in the table.
    table = Terminal::Table.new rows: [
      ['Ticket ID', @id.to_s],
      ['Requester ID', @requester_id.to_s],
      ['Assignee ID', @assignee_id.to_s],
      ['Tags', @tags.to_s],
      ['Subject', @subject.to_s],
      ['Description', @description.to_s.scan(/.{1,66}[ \W\d]/).join("\n")]
    ]

    # displays the table with a top and bottom newline
    # to avoid clutter.
    puts
    puts table
    puts

    # Explanation of @description.to_s.scan(/.{1,66} /).join("\n") -
    #
    # Adds a newline every 66 characters .{1,66}
    # + a space [ ]
    # + possibly a group of digits / punctuation [\W\d]
    #   - \W : not a word (catches punctuation)
    #   - \d : a digit    (catches digits)
    # Done so that long ticket descriptions print nicely in the terminal.

    # Example output of Ticket#display -
    # +--------------+--------------------------------------------------------------------+
    # | Ticket ID    | 2                                                                  |
    # | Requester ID | 902131179606                                                       |
    # | Assignee ID  | 902131179606                                                       |
    # | Tags         | ["est", "incididunt", "nisi"]                                      |
    # | Subject      | velit eiusmod reprehenderit officia cupidatat                      |
    # | Description  | Aute ex sunt culpa ex ea esse sint cupidatat aliqua ex consequat   |
    # |              | sit reprehenderit. Velit labore proident quis culpa ad duis        |
    # |              | adipisicing laboris voluptate velit incididunt minim consequat     |
    # |              | nulla. Laboris adipisicing reprehenderit minim tempor officia      |
    # |              | ullamco occaecat ut laborum.                                       |
    # |              |                                                                    |
    # |              | Aliquip velit adipisicing exercitation irure aliqua qui. Commodo   |
    # |              | eu laborum cillum nostrud eu. Mollit duis qui non ea deserunt est  |
    # |              | est et officia ut excepteur Lorem pariatur deserunt.               |
    # +--------------+--------------------------------------------------------------------+

  end
end
