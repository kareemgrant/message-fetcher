require 'spec_helper'
include Rack::Test::Methods

describe MessageFetcher do

  describe ".for_tracks" do
    context "with valid credentials" do
      it "should return a 200 status response" do
        response = MessageFetcher.for_tracks(1)
        expect(response.status).to eq 200
      end

      it "should only return messages for the specified track_id" do
        response = MessageFetcher.for_tracks(1)
        messages = JSON.parse(response.body)
        expect(messages.first["track_id"]).to eq 1
      end
    end

    context "with invalid credentials" do
      xit "raises an InvalidCredentials error if track_id is not an integer" do
      end
    end
  end

  describe ".create_message" do

    context "with valid credentials" do
      xit "should return a 201 status response" do
      end
      xit "should return the created message in json format" do
      end
    end

    context "with invalid credentials" do
      xit "raises an InvalidCredentials error if track_id is invalid" do
      end
      xit "raises an InvalidCredentials error if user_id is invalid" do
      end
      xit "raises an InvalidCredentials error if message body is missing" do
      end
    end
  end
end
