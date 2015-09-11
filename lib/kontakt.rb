# For use with Kontakt.io API only.
# http://docs.kontakt.io/rest-api

# This is an unoffical gem for Kontakt.io
# the authors have no affiliation Kontakt.io

require 'rest-client'
require 'yaml'

class Kontakt
  GEM_ROOT = File.expand_path("../..", __FILE__)
  AUTH_INFO = YAML.load_file("#{GEM_ROOT}/config/kontakt.yml")
  API_URL = "https://api.kontakt.io"
  RESOURCE_DATA = {:accept => "application/vnd.com.kontakt+json;version=5", :"Api-Key" => AUTH_INFO["key"]}

  # => Kontakt Authentication
  def initialize
    @resource = RestClient::Resource.new API_URL
  end

  # ==========================
  # => Venues
  def venue_list
    return @resource['/venue'].get RESOURCE_DATA
  end
  
  # ==========================
  # => Devices / Beacons
  def device_list(managerId = [])
    # => managerId can be manager UUID's in an array
    return @resource['/device'].get {:params => {:managerId => managerId.join(',')}}, RESOURCE_DATA
  end

  def device_by_id(id)
    return @resource['/device/' + id].get RESOURCE_DATA
  end

end
