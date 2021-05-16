# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby '~> 3.0.0'

####################
# Application Gems #
####################

# Minitest used for unit testing.
gem 'minitest', '~> 5.14.4' 

# We use rake to automate the running of our test suite.
# See the 'rakefile' in the project index.
gem 'rake', '~> 13.0.3'

# terminal-table is used to format our ticket output as a table.
# see Ticket class file where it is used in the Ticket#display method.
gem 'terminal-table', '~> 3.0'

# The zendesk_api gem is used to easily interface with the Zendesk API.
gem 'zendesk_api', '~> 1.29.0'

# dotenv is used to load environmental variables into our application.
# This ensures they are not stored publicly in source control (ie on GitHub),
# and thus our application secrets are kept secret.
gem 'dotenv', '~> 2.7.6'
