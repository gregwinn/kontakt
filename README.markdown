# Kontakt Gem [In development NOT APPROVED FOR PRODUCTION]
#### For use with the Kontakt.io API V6 only.


__This is an unofficial gem for Kontakt.io the authors have no affiliation Kontakt.io__

[![Gem Version](https://badge.fury.io/rb/kontakt.svg)](http://badge.fury.io/rb/kontakt) [![Build Status](https://travis-ci.org/gregwinn/kontakt.svg)](https://travis-ci.org/gregwinn/kontakt)
----

## Install Kontakt gem
Add the following to your Gemfile
```
gem "kontakt", "~> 0.1.4"
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

## Resources
Each class is named after a Kontakt API resource, and is always preceded by the module name `Kontakt::CLASS.METHOD`.

* [Analytics](https://github.com/gregwinn/kontakt/wiki/Analytics)
* [Config](https://github.com/gregwinn/kontakt/wiki/Config)
* [Device](https://github.com/gregwinn/kontakt/wiki/Device)
* [Firmware](https://github.com/gregwinn/kontakt/wiki/Firmware)
* [Venue](https://github.com/gregwinn/kontakt/wiki/Venue)
