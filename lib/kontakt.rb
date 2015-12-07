# For use with Kontakt.io API only.
# http://docs.kontakt.io/rest-api

# This is an unoffical gem for Kontakt.io
# the authors have no affiliation Kontakt.io

require 'rest-client'
require 'yaml'

module Kontakt
  API_URL = "https://api.kontakt.io"


  class Configuration
	    attr_accessor :key
	    def initialize
	      self.key 		= nil
	    end
	end

	def self.configuration
	  @configuration ||=  Configuration.new
	end

	def self.configure
	  yield(configuration) if block_given?
	end

	class << self
		attr_accessor :key
		def key
	    	raise "The API key is needed" unless @key
	    	@key
	  end
	end

  def self.resource_data
    return {:accept => "application/vnd.com.kontakt+json;version=6", :"Api-Key" => Kontakt.configuration.key, :content_type => "application/x-www-form-urlencoded"}
  end

  class Auth < Configuration
    # => Kontakt Authentication
    def self.make_request(method, path, options = {}, payload = {})
      RestClient::Request.execute(method: method.to_sym, url: API_URL + path, payload: payload, headers: options.merge(Kontakt.resource_data), verify_ssl: false)
    end
  end

  class Venue < Auth
    # ==========================
    # => Venues
    def self.list
      return JSON.parse(make_request('get', '/venue').body)
    end

    def self.create(name, description, options = {})
      return JSON.parse(make_request('post', '/venue/create', {}, {:name => name, :description => description}.merge(options)).body)
    end
  end

  class Config < Auth

    def self.pending(deviceType)
      return JSON.parse(make_request('get', '/config', {params: {:deviceType => deviceType}}).body)
    end

    def self.pending_by_id(uniqueId)
      return JSON.parse(make_request('get', '/config/' + uniqueId).body)
    end

    def self.create(uniqueId, deviceType, options = {})
      return JSON.parse(make_request('post', '/config/create', {}, {:uniqueId => uniqueId, :deviceType => deviceType}.merge(options)).body)
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

    def self.unassigned(managerId, options = {})
      return JSON.parse(make_request('get', '/device/unassigned/' + managerId, {params: options}).body)
    end

    def self.assign_venue(venueId, deviceId)
      return make_request('post', '/device/assign', {}, {:venueId => venueId, :deviceId => deviceId})
    end

    def self.assign_manager(managerId, deviceId)
      return make_request('post', '/device/assign', {}, {:deviceId => deviceId, :managerId => managerId})
    end

    def self.by_id(id)
      return JSON.parse(make_request('get', '/device/' + id).body)
    end

    def self.status(id)
      return JSON.parse(make_request('get', '/device/' + id + '/status').body)
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
      return JSON.parse(make_request('get', '/analytics/metrics/ranges', request_options).body)
    end

  end

  class Firmware < Auth
    # ==========================
    # => Firmware

    def self.latest(uniqueId, options = {deviceType: ''})
      request_options = {
        params: {
          :uniqueId => uniqueId,
          :deviceType => options[:deviceType]
        }
      }
      return JSON.parse(make_request('get', '/firmware/last', request_options))
    end
  end

end
