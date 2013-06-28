require 'message_fetcher/version'
require 'pry'
require 'faraday'
require 'json'

module MessageFetcher
  extend self

  def for_tracks(track_id)
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
   response = conn.get do |req|
      req.url "/api/tracks/#{track_id}/messages"
    end
   JSON.parse(response.body)
  end

  def post_messages(data)
    response = conn.post do |req|
      req.url "/api/tracks/#{data[:track_id]}/messages"
      req.headers['Content-Type'] = 'application/json'
      req.body = {message: { user_id: data[:user_id], body: data[:body]}}.to_json
    end
    JSON.parse(response.body)
  end

  def base_url
    "http://localhost:3002"
  end
end

class InvalidCredentials < StandardError; end
