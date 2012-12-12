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
		class DnsZoneList < Knife

			include Knife::DnsBase

			banner "knife dns zone list (options)"

			def run
				domains = [
				  ui.color('ID', :bold),
				  ui.color('Domain', :bold),
 				  ui.color('Nameservers', :bold)
				]

				self.connection.zones.sort_by(&:domain).each do |i|
				  domains << i.id.to_s
				  domains << i.domain
				  domains << i.nameservers.join( ' ' )
				end

				puts ui.list(domains, :uneven_columns_across, 3)
			end
		end
	end
end

# {"domain"=>
#   {"auto_renew"=>nil,
#    "created_at"=>"2012-12-12T18:58:18Z",
#    "expires_at"=>nil,
#    "id"=>50874,
#    "language"=>nil,
#    "lockable"=>true,
#    "name"=>"playland.modcloth.com",
#    "name_server_status"=>"unknown",
#    "parsed_expiration_date"=>nil,
#    "registrant_id"=>nil,
#    "state"=>"hosted",
#    "token"=>"bWigD1go7DYsWYQoScBSUFGx_Pv60_ciKA",
#    "unicode_name"=>"playland.modcloth.com",
#    "updated_at"=>"2012-12-12T18:58:18Z",
#    "user_id"=>12678,
#    "record_count"=>0,
#    "service_count"=>0,
#    "private_whois?"=>false,
#    "expires_on"=>nil}}
# => {"domain"=>{"auto_renew"=>nil, "created_at"=>"2012-12-12T18:58:18Z", "expires_at"=>nil, "id"=>50874, "language"=>nil, "lockable"=>true, "name"=>"playland.modcloth.com", "name_server_status"=>"unknown", "parsed_expiration_date"=>nil, "registrant_id"=>nil, "state"=>"hosted", "token"=>"bWigD1go7DYsWYQoScBSUFGx_Pv60_ciKA", "unicode_name"=>"playland.modcloth.com", "updated_at"=>"2012-12-12T18:58:18Z", "user_id"=>12678, "record_count"=>0, "service_count"=>0, "private_whois?"=>false, "expires_on"=>nil}}
