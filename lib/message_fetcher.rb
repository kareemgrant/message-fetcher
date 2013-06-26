require 'message_fetcher/version'
require 'pry'
require 'faraday'
require 'json'

module MessageFetcher
  extend self

  def for_tracks(track_id)
    validate_params(track_id)
    fetch_messages(track_id)
  end

  def create_message(data)
    post_messages(data)
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

  def post_messages(data)
    conn.post do |req|
      req.url "/api/messages"
      req.headers['Content-Type'] = 'application/json'
      req.body = {message: data}.to_json
    end
  end

  def base_url
    "http://localhost:3002"
  end

  def validate_params(track_id)
    raise InvalidCredentials unless track_id.is_a?(Integer)
  end
end

class InvalidCredentials < StandardError; end
