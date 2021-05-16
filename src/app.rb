# frozen_string_literal: true

require 'dotenv'
require_relative './Application/application'

# check that environment variables have been properly loaded.
# warn the user if that is not the case.
#
# checks if .env is in the current or parent directory,
# so that if you're in the src/ directory you can run 'ruby app.rb'
# and if you're in the root directory you can run 'ruby src/app.rb'.
begin
  Dotenv.load('../.env', '.env')
  Dotenv.require_keys('API_URL', 'API_TOKEN', 'API_USERNAME')
rescue Dotenv::MissingKeys => e
  puts
  puts "\t *** Warning ***"
  puts 'Key/s are missing from your .env file.'
  puts e.to_s
  puts
end

# Load in application secrets / details from .env file.
# These secrets should only be kept locally and not committed to source control.
API_URL = ENV['API_URL']
API_TOKEN = ENV['API_TOKEN']
API_USERNAME = ENV['API_USERNAME']

# Create an instance of the application,
# and displays a welcome message.
app = Application.new(API_URL, API_USERNAME, API_TOKEN)
app.welcome_user

# Check whether the Zendesk API is available.
# If issues are detected, a warning message is displayed,
# however the user can still try and use the application.
app.check_api_available

# On each iteration -
# 1: display input options to the user.
# 2: receive user input.
# 3: execute based on user input.
# 4: exit if the user has indicated they want to quit.
loop do

  app.display_prompt
  app.handle_input(gets.chomp.to_i)

  # break out of the application if our user wishes to exit.
  app.quit_application ? break : next

end
