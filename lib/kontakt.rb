# For use with Kontakt.io API only.
# http://docs.kontakt.io/rest-api

# This is an unoffical gem for Kontakt.io
# the authors have no affiliation Kontakt.io

require 'rest-client'
require 'yaml'

module Kontakt
  GEM_ROOT = File.expand_path("../..", __FILE__)
  AUTH_INFO = YAML.load_file("#{GEM_ROOT}/config/kontakt.yml")
  API_URL = "https://api.kontakt.io"
  RESOURCE_DATA = {:accept => "application/vnd.com.kontakt+json;version=5", :"Api-Key" => AUTH_INFO["key"], :content_type => "application/x-www-form-urlencoded"}

  class Auth
    # => Kontakt Authentication
    def self.make_request(method, path, options = {}, payload = {})
      RestClient::Request.execute(method: method.to_sym, url: API_URL + path, payload: payload, headers: options.merge(RESOURCE_DATA))
    end
  end

  class Venue < Auth
    # ==========================
    # => Venues
    def self.list
      return JSON.parse(make_request('get', '/venue').body)
    end
  end

  class Device < Auth
    # ==========================
    # => Devices / Beacons
    def self.list(managerId = [])
      # => managerId can be manager UUID's in an array
      return JSON.parse(make_request('get', '/device', {params: {:managerId => managerId.join(',')}}).body)
    end

    def self.by_id(id)
      return JSON.parse(make_request('get', '/device/' + id).body)
    end

    def self.update(id, type, options = {})
      return make_request('post', '/device/update', {}, {:uniqueId => id, :deviceType => type}.merge(options))
    end
  end

  class Analytics < Auth
    # ==========================
    # => Analytics
    def self.metrics_ranges(venue_id, startTime, options = {endTime: Time.now.to_i, maxResults: 100})

      request_options = {
        params: {:sourceType => "VENUE",
                :sourceId => venue_id,
                :iso8601Timestamps => "true",
                :startTimestamp => startTime,
                :endTimestamp => options[:endTime],
                :maxResults => options[:maxResults]}
      }
      return JSON.parse(make_request('get', '/analytics/metrics/ranges', request_options, {}).body)
    end

  end

end
