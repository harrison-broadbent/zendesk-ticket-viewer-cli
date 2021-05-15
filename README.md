# zendesk-ticket-viewer-cli

Zendesk Ticket Viewer CLI application for the Zendesk coding interview challenge

## Getting Setup

### Creating Tickets

Ensure that a tickets.json file exists and is populated with a ticket JSON object.

Use the one available from -

https://gist.githubusercontent.com/svizzari/c7ffed8e10d3a456b40ac9d18f34289c/raw/325e600e7c8aac3643fc75cb7a4228dfa99eb02e/tickets.json

if needed.

Use the following command to add these tickets to your Zendesk using the Ticket Import API -

```bash

curl https://zendesk-internship-challenge.zendesk.com/api/v2/imports/tickets/create_many.json -v -u {email_address}:{password} -X POST -d @tickets.json -H "Content-Type:application/json"

```

Inserting your own credentials where necessary, and ensuring that API access is enabled in your Zendesk setup.

## Testing

Testing is done using the Minitest gem.

Tests are located in the /tests directory.

Tests can be run individually by running -

```sh
ruby tests/..._test.rb
```

However, a rakefile has been setup to run all the tests automatically. They can be run by executing -

```sh
rake
```

from the root directory of the project.
Any additional tests added to the tests/ directory will also be run.
