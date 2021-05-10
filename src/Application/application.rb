require_relative '../Tickets/tickets'

# Manage the operations of the application
# Handles the Console I/O, and interacts with the Tickets class to display tickets
class Application
  attr_accessor :quit_application

  def initialize(url, username, api_token)
    @token = api_token
    @quit_application = false

    @tickets = Tickets.new(url, username, api_token)
  end

  def welcome_user
    puts '____________________________________'
    puts
    puts 'Welcome to the Zendesk Ticket Viewer.'
    puts 'Built with <3 by Harrison Broadbent.'
    puts
    puts "____________________________________\n"
  end

  def display_prompt
    puts 'Please select from the following options -'
    puts
    puts "\t1 : View all tickets (paginated to 25)"
    puts "\t2 : View a specific ticket"
    puts "\t3 : Exit the application"
    puts
    print '> '
  end

  def check_api_available()
    puts ""
  
    begin
      test_ticket = @tickets.get_single(2)
    rescue ZendeskAPI::Error::NetworkError
      puts "\t *** Warning ***"
      puts "We are having trouble connecting to Zendesk."
      puts "We recommend you try again later."
    rescue
      puts "\t *** Warning ***"
      puts "We are experiencing some unknown issues"
      puts "We recommend you trying again later."
    else
      puts "We have checked the API and it seems to be ready to go."
    end
    
    puts
  end

  def handle_input(input)
    input = input.to_i

    case input
    when 1
      # page to 25 per page max here
      ticketCollection = @tickets.get_all
      ticketCollection.each_with_index do |ticket, index|
        # display a page header if we are on a new page
        # and display a footer and wait for the user to proceed if we have just finished a page
        if (index % 25 == 0)
          if (index != 0)
            pagenum = index / 25;
            puts "________ End of Page #{pagenum} _________"
            puts "[ENTER] for the next page: "
            puts
            gets
            puts "____________ Page #{pagenum} ____________"
          end
        end 

        # regardless, display the ticket
        puts "******"
        ticket.display
        puts "******"
      end

    when 2
      puts 'Enter a ticket ID : '
      print '> '
      @tickets.get_single(gets.chomp.to_i).display

    when 3
      @quit_application = true
      puts 'Goodbye, have a nice day'

    else
      puts 'Please enter a valid option'
    end
  end
end