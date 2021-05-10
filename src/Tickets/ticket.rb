require 'terminal-table'

class Ticket
  # def initialize(requester_id = "", assignee_id = "", subject = "", description = "", tags = "")
  #   @requester_id = requester_id
  #   @assignee_id = assignee_id
  #   @subject = subject
  #   @description = description
  #   @tags = tags.map(&:id)
  # end

  def initialize(data)
    @requester_id = data.requester_id
    @assignee_id = data.assignee_id
    @subject = data.subject
    @description = data.description
    @tags = data.tags.map(&:id)
  end

  def display

    table = Terminal::Table.new :rows => [
      ["Requester ID", @requester_id.to_s],
      ["Assignee ID", @assignee_id.to_s],
      ["Tags", @tags.to_s], 
      ["Subject", @subject.to_s],
      ["Description", @description.to_s.scan(/.{1,66} /).join("\n")]
    ]

    # Explanation of @description.to_s.scan(/.{1,66} /).join("\n") - 
    # Adds a newline every 66 characters + a space
    # Done so that long ticket descriptions print nicely in the terminal

    puts
    puts table
    puts

    # puts
    # puts "Requester ID  \t: " + @requester_id.to_s
    # puts "Assignee ID   \t: " + @assignee_id.to_s
    # puts "Tags          \t: " + @tags.to_s
    # puts "Subject       \t: " + @subject.to_s
    # puts "Description   \t: " + @description.to_s
    # puts
  end
end
