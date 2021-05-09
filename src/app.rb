require_relative "./Application/application.rb"

# Hardcode the API token for simplicity
# Store in an evironmental variable if security is a concern
API_URL = "https://zendesk-internship-challenge.zendesk.com/api/v2"
API_USERNAME = "harrisonbroadbent@gmail.com"
API_TOKEN = 'yfqST59724N6IMnG0z4yxcupZR6tmc1ySJwGsAaB'

# Create an instance of the application, 
# Begin the main application loop
app = Application.new(API_URL, API_USERNAME, API_TOKEN)
app.welcome_user()

# Check whether the Zendesk API is available
app.check_api_available()

# On each iteration - 
# 1: display the options to the user
# 2: recieve user input
# 3: execute based on user input
while true

  app.display_prompt
  app.handle_input(gets.chomp)

	# break out of the application if our user wishes to exit
	app.quit_application ? break : next

end
