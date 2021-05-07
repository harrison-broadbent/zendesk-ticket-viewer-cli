class Ticket
  def initialize(requester_id, assignee_id, subject, description, tags)
    @requester_id = requester_id
    @assignee_id = assignee_id
    @subject = subject
    @description = description
    @tags = tags
  end

  def display
    puts "Requester ID \t: " + @requester_id
    puts "Assignee ID  \t: " + @assignee_id
    puts "Subject      \t: " + @subject
    puts "Description  \t: " + @description
    puts "Tags \t\t\t\t\t: " + @tags
  end
end
