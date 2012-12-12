# Author:: Stephen Lauck (<stephen.lauck@gmail.com>)
# Copyright:: Copyright (c) 2011-2012
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'chef/knife/dns_base'

class Chef
	class Knife
		class DnsZoneCreate < Knife

			include Knife::DnsBase

			banner "knife dns zone create (options)"

			option :domain,
				:short => "-D DOMAIN",
				:long => "--domain DOMAIN",
				:description => "Domain name for zone"

				
			option :email,
				:short => "-M EMAIL",
				:long => "--email EMAIL",
				:description => "Domain email for zone"

			def run
				
				unless config[:domain]
          ui.error("You have not provided a domain name")
          show_usage
          exit 1
        end

				zone = self.connection.zones.create({
					:domain => config[:domain],
					:email => config[:email]
				})

				puts ui.color("Created zone:", :cyan)
        msg_pair("ID", zone.id.to_s)
        msg_pair("Domain", zone.domain)
			end
		end
	end
end
