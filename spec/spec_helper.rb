require 'rspec'
require 'message_fetcher'
require 'vcr'

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
end

