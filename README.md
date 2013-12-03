Knife DNS
=========

Knife plugin that can be used to CRUD dns records and zones using the FOG::DNS support.

## Installation

Add this line to your application's Gemfile:

		gem 'knife-dns'

And then execute:

		$ bundle

Or install it yourself as:

		$ gem install knife-dns

## Configuration

In order to communicate with a cloud DNS provider or a local dns server you must tell knife your provider, username, and api key or password in your knife.rb file:

	knife[:dns] = { provider details and credentials here }

Ex.

	knife[:dns] = {
		:provider     => "Zerigo",
		:zerigo_email => "john@example.com",
		:zerigo_token => "4678e902..." 
	}

## Usage

For a list of commands 

	`knife dns --help`

Available commands:

	knife dns zone create
	knife dns zone delete
	knife dns zone list
	knife dns record create
	knife dns record delete
	knife dns record list

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
