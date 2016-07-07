Gem::Specification.new do |s|
  s.name        = 'kontakt'
  s.version     = '1.0.6'
  s.date        = '2015-12-07'
  s.summary     = "Kontakt"
  s.description = "For use with Kontakt.io API (iBeacon / EddyStone) Beacons, and Cloud Beacons"
  s.authors     = ["Greg Winn"]
  s.email       = 'winn.greg@gmail.com'
  s.files       = ["lib/kontakt.rb"]
  s.homepage    = 'https://github.com/gregwinn/kontakt'
  s.license     = 'MIT'

  s.add_runtime_dependency 'rest-client', '~> 2.0', '>= 2.0.0'
end
