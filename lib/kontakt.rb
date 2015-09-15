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
  RESOURCE_DATA = {:accept => "application/vnd.com.kontakt+json;version=6", :"Api-Key" => AUTH_INFO["key"], :content_type => "application/x-www-form-urlencoded"}

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
    def self.list(options = {})
      # => managerId needs to be a string separated by comma for more then one
      #  managerIds = array | managerIds.join(',') before passing to Device.list
      return JSON.parse(make_request('get', '/device', {params: options}).body)
    end

    def self.unassigned(managerId)
      return JSON.parse(make_request('get', '/device/unassigned/' + managerId))
    end

    def self.assign(venueId, deviceId)
      return make_request('post', '/device/assign', {}, {:venueId => venueId, :deviceId => deviceId})
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
