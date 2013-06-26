require 'message_fetcher/version'
require 'pry'
require 'faraday'
require 'json'

module MessageFetcher
  extend self

  def for_tracks(track_id)
    fetch_messages(track_id)
  end

private

  def conn
    conn = Faraday.new(:url => base_url) do |c|
      c.use Faraday::Adapter::NetHttp
    end
  end

  def fetch_messages(track_id)
    conn.get do |req|
      req.url "/api/messages/#{track_id}"
    end
  end

  def base_url
    "http://localhost:3002"
  end
end
