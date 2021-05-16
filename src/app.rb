require 'dotenv'
require_relative './Application/application'

# check that environment variables have been properly loaded
# warn the user if that is not the case
begin
  Dotenv.load('../.env')
  Dotenv.require_keys('API_URL', 'API_TOKEN', 'API_USERNAME')
rescue Dotenv::MissingKeys => e
  puts
  puts "\t *** Warning ***"
  puts 'Key/s are missing from your .env file.'
  puts e.to_s
  puts
end

# Load in application secrets / details from .env file
# These secrets should only be kept locally and not committed to source control
API_URL = ENV['API_URL']
API_TOKEN = ENV['API_TOKEN']
API_USERNAME = ENV['API_USERNAME']

# Create an instance of the application,
# Begin the main application loop
app = Application.new(API_URL, API_USERNAME, API_TOKEN)
app.welcome_user()

# Check whether the Zendesk API is available
app.check_api_available()

# On each iteration -
# 1: display the options to the user
# 2: receive user input
# 3: execute based on user input
while true

  app.display_prompt
  app.handle_input(gets.chomp)

	# break out of the application if our user wishes to exit
	app.quit_application ? break : next

end
