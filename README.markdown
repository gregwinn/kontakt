# Kontakt Gem [In development NOT APPROVED FOR PRODUCTION]
#### For use with the Kontakt.io API V6 only.


__This is an unofficial gem for Kontakt.io the authors have no affiliation Kontakt.io__

[![Gem Version](https://badge.fury.io/rb/kontakt.svg)](http://badge.fury.io/rb/kontakt) [![Build Status](https://travis-ci.org/gregwinn/kontakt.svg)](https://travis-ci.org/gregwinn/kontakt)
----

## Install Kontakt gem
Add the following to your Gemfile
```
gem "kontakt", "~> 0.1.0"
```
After adding the gem to your Gemfile, run `bundle install`.

Install it as a stand alone gem
```
gem install kontakt
```

#### Add the config file
A configuration YML file is needed, that simply contains your API KEY.

Add: `/config/kontakt.yml`

```
# Kontakt API KEY
key: "000000000000000000"
```


__Add an Environment Variable__
```
export KONTAKT_CONFIG_PATH=config/kontakt.yml
```

----

## Venue

#### Venue.list
http://docs.kontakt.io/rest-api/stable/resources/#venue-get-venues
Displays all Venues.

__Example__
```
Kontakt::Venue.list
```

#### Venue.create("name", "description", {options})
http://docs.kontakt.io/rest-api/stable/resources/#venue-create-new-venue
Allows you to create a new Venue.

__Example__
```
Kontakt::Venue.create("Venue Name", "A small place", {lat: 52, lng: -118})
```

## Device
This includes regular beacons along with cloud beacons

#### Device.list({options})
http://docs.kontakt.io/rest-api/stable/resources/#device-device-overview
Lists all devices attached to your account. You may add additional options as a hash to limit the list.

##### options
All options should be passed as a hash based on the 'name' attribute from Kontakt device overview.

__Example__
```
Kontakt::Device.list
```
Using without options will return ALL devices.

__Example with options__
```
Kontakt::Device.list({deviceType: "CLOUD_BEACON", managerId: "xxxxxx-xxxxx-xxxxxxxx"})
```
This will return all `CLOUD_BEACON` assigned to `managerId`.

----
#### Device.unassigned("managerId")
http://docs.kontakt.io/rest-api/stable/resources/#device-get-devices-not-assigned-to-a-venue
Lists all devices not assigned a venue

__Example__
```
Kontakt::Device.unassigned("xxxxxx-xxxxx-xxxxxxxx")
```

----
#### Device.assign_venue("venueId", "deviceId")
http://docs.kontakt.io/rest-api/stable/resources/#device-assign-devices-to-a-venue
Assign a device to a venue.

__NOTE:__ `deviceId` is the UUID and NOT the short ID provided by Kontakt

__Example__
```
Kontakt::Device.assign_venue("xxxxxx-xxxxx-xxxxxxxx", "xxxxxx-xxxxx-xxxxxxxx")
```

----
#### Device.assign_manager("managerId", "deviceId")
http://docs.kontakt.io/rest-api/stable/resources/#device-assign-devices-to-a-manager
Assign device(s) to a manager.

__NOTE:__ `deviceId` is the UUID and NOT the short ID provided by Kontakt

__NOTE 2:__ `deviceId` can contain more then one ID, it should be a comma separated `string`

__Example__
```
Kontakt::Device.assign_manager("xxxxxx-xxxxx-xxxxxxxx", "xxxxxx-xxxxx-xxxxxxxx,xxxxxx-xxxxx-xxxxxxxx")
```

----
#### Device.by_id("uniqueId")
http://docs.kontakt.io/rest-api/stable/resources/#device-get-device-by-unique-id
Find a device by uniqueId (the short ID on the beacon sticker 'Y0lo')

__Example__
```
Kontakt::Device.by_id("Y0lo")
```
----
#### Device.update("uniqueId", "deviceType", {options})
http://docs.kontakt.io/rest-api/stable/resources/#beacon-update-a-beacon
Update the beacons attributes.

__NOTE:__ `uniqueId` is the short ID used on the sticker NOT the UUID.

__Example__
```
Kontakt::Device.update("Y0lo", "BEACON", {alias: "MyBeacon", minor: 836})
```


## Analytics

#### Analytics.metrics_ranges("venue_id", "startTime", options = {endTime: Time.now.to_i, maxResults: 100})
http://docs.kontakt.io/rest-api/stable/resources/#analytics-range-metrics
Using a Cloud Beacon, you may view near by BLE devices.

__Example__
```
Kontakt::Analytics.metrics_ranges("xxxxxx-xxxxx-xxxxxxxx", (Time.now - 3600).to_i, {iso8601Timestamps: true, maxResults: 10})
```


## Firmware

#### Firmware.latest(["uniqueId"], options = {deviceType: ""})
http://docs.kontakt.io/rest-api/stable/resources/#firmware-get-latest-firmware-information
Get latest Firmware information: If no firmware update is available for the specified devices, then an empty JSON object will be returned.

__NOTE:__ `uniqueId` is the short ID used on the sticker NOT the UUID.

__Example__
```
Kontakt::Firmware.latest("Y0lo,Y2kf")
```
