# frozen_string_literal: true

require_relative '../Tickets/tickets'

# Manages most of the user-facing parts of the application.
# Handles the Console I/O, and interacts with the Tickets class to display tickets.
class Application
  attr_accessor :quit_application

  # @quit_application is used to signal to app.rb that the user wants to quit.
  # @tickets is an instance of the Tickets class initialized with appropriate credentials
  #
  # INPUT:
  # url:        string
  # username:   string
  # api_token:  string
  def initialize(url, username, api_token)
    @quit_application = false
    @tickets = Tickets.new(url, username, api_token)
  end

  # Displays a welcome message in the console.
  # Called once when the application begins.
  def welcome_user
    puts '____________________________________'
    puts
    puts 'Welcome to the Zendesk Ticket Viewer.'
    puts 'Built with <3 by Harrison Broadbent.'
    puts
    puts "____________________________________\n"
  end

  # Displays the possible actions to the user.
  # Called on every iteration of the main application loop.
  def display_prompt
    puts
    puts 'Please select from the following options -'
    puts
    puts "\t1 : View all tickets (paginated to 25)"
    puts "\t2 : View a specific ticket"
    puts "\t3 : Exit the application"
    puts
    print '> '
  end

  # Checks whether the Zendesk API is available by issuing a request to the API.
  # Tickets normally handles errors itself, but the Tickets#get_test_ticket method
  # deliberately avoids this so that any errors are surfaced.
  def check_api_available
    puts ''

    begin
      @tickets.get_test_ticket
    rescue ZendeskAPI::Error::NetworkError
      puts "\t *** Warning ***"
      puts 'We are having trouble connecting to Zendesk.'
      puts 'We recommend you try again later.'
    rescue StandardError
      puts "\t *** Warning ***"
      puts 'We are experiencing some unknown issues'
      puts 'We recommend you trying again later.'
    else
      puts 'We have checked the API and it seems ready for action.'
    end

    puts
  end

  # Generic method for managing input from the user.
  #
  # INPUT:
  # input: integer
  def handle_input(input)

    # case input:
    # when 1: display all tickets
    # when 2: display a single ticket by id
    # when 3: set @quit_application to true, indicating that the user wants to quit
    case input
    when 1
      # Display all tickets.
      # Uses the pagination implemented in Tickets#get_page
      # to get a page of tickets at a time.
      #
      # As per the brief, each page is 25 tickets long,
      # however that can be modified by changing the value of per_page.
      page_number = 1
      per_page = 25
      tickets_paginated = @tickets.get_page(page_number, per_page)

      # if there are no tickets on page page_number,
      # Tickets#get_page will return an empty array and tickets_paginated will be nil.
      # Until this happens, we want to display pages of tickets.
      #
      # if an error occurs when calling Tickets#get_page, nil will be returned.
      #
      # The outer if-else condition catches the instance where Tickets#get_page
      # returns a nil response on the initial call (above).
      # This can occur if we can't connect to the API..
      if !tickets_paginated.nil?
        until tickets_paginated.empty?
          puts "____________ Page #{page_number} ____________"

          tickets_paginated.each(&:display)

          puts "________ End of Page #{page_number} _________"
          puts '[ENTER] for the next page: '
          puts
          gets

          page_number += 1
          tickets_paginated = @tickets.get_page(page_number, per_page)
        end
      else
        puts 'No tickets to display'
      end

    when 2  # display a single ticket.
      puts 'Enter a ticket ID : '
      print '> '
      @tickets.get_single(gets.chomp.to_i).display

    when 3  # signals that the user is ready to quit.
      @quit_application = true
      puts 'Goodbye, have a nice day.'

    else  # handles invalid input.
      puts 'Please enter a valid option'
    end

  end
end
