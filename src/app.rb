require_relative "./Application/application.rb"

# Hardcode the API token for simplicity
# Store in an evironmental variable if security is a concern
API_URL = "https://harrison-development.zendesk.com/api/v2"
API_USERNAME = "development.harrison@gmail.com"
API_TOKEN = 'lqJauN9eTuebk2abaR0Im6SjzZ2xDNDbGxELl4ru'

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
