class Application

	attr_accessor :quit_application

  def initialize(api_token)
    @token = api_token
		@quit_application = false
  end

  def welcomeUser

    puts "____________________________________"
		puts 
		puts "Welcome to the Zendesk Ticket Viewer."
		puts "Built with <3 by Harrison Broadbent."
		puts 
    puts "____________________________________\n"

  end

  def displayPrompt

		puts "Please select from the following options -"
		puts
		puts "\t1 : View all tickets (paginated to 25)"
		puts "\t2 : View a specific ticket"
		puts "\t3 : Exit the application"
		puts
		print "> "

  end

  def handleInput(input)

		input = input.to_i

		case input
		when 1
			puts input
		when 2
			puts input
		when 3 then @quit_application = true; puts "Goodbye, have a nice day"
		else
			puts "Please enter a valid option"
		end


	end

end

