Gem::Specification.new do |s|
  s.name        = 'kontakt'
  s.version     = '1.0.7'
  s.date        = '2016-10-19'
  s.summary     = "Kontakt"
  s.description = "For use with Kontakt.io API (iBeacon / EddyStone) Beacons, and Cloud Beacons"
  s.authors     = ["Greg Winn", "Patrick Steiner"]
  s.email       = 'winn.greg@gmail.com'
  s.files       = ["lib/kontakt.rb"]
  s.homepage    = 'https://github.com/gregwinn/kontakt'
  s.license     = 'MIT'

  s.add_runtime_dependency 'rest-client', '~> 2.0', '>= 2.0.0'
end
