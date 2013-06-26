require 'spec_helper'

describe MessageFetcher do

  describe ".for_tracks" do
    context "with valid credentials" do
      it "should return a 200 status response" do
        VCR.use_cassette('backchannel-messages check 200 status') do
          response = MessageFetcher.for_tracks(1)
          expect(response.status).to eq 200
        end
      end

      it "should only return messages for the specified track_id" do
        VCR.use_cassette('backchannel-messages check track_id') do
          response = MessageFetcher.for_tracks(1)
          messages = JSON.parse(response.body)
          expect(messages.first["track_id"]).to eq 1
        end
      end
    end

    context "with invalid credentials" do
      it "raises an InvalidCredentials error if track_id is not an integer" do
        expect { MessageFetcher.for_tracks("reem") }.to raise_error InvalidCredentials
      end
    end
  end

  describe ".create_message" do
    context "with valid credentials" do
      it "should return a 201 status response" do
        VCR.use_cassette('backchannel-messages .create_message check status') do
          data = { body: "Hello world", user_id: 3, track_id: 2}
          response = MessageFetcher.create_message(data)
          expect(response.status).to eq 201
        end
      end

      it "should return the created message in json format" do
        data = { body: "Hello world", user_id: 3, track_id: 2}
        response = MessageFetcher.create_message(data)
        expect(JSON.parse(response.body)["body"]).to eq "Hello world"
        expect(JSON.parse(response.body)["user_id"]).to eq 3
        expect(JSON.parse(response.body)["track_id"]).to eq 2
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
