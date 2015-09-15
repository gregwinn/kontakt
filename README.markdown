# Kontakt Gem
#### For use with the Kontakt.io API only.

__This is an unoffical gem for Kontakt.io the authors have no affiliation Kontakt.io__

----

## Install Kontakt gem
Add the following to your Gemfile
```
gem "kontakt"
```
After adding the gem to your Gemfile, run `bundle install`.

Install it as a stand alone gem
```
gem install kontakt
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
#### Device.assign("venueId", "deviceId")
http://docs.kontakt.io/rest-api/stable/resources/#device-assign-devices-to-a-venue
Assign a device to a venue.

__Example__
```
Kontakt::Device.assign("xxxxxx-xxxxx-xxxxxxxx", "xxxxxx-xxxxx-xxxxxxxx")
```
