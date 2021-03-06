require 'spec_helper'

describe MessageFetcher do

  describe ".for_tracks" do
    context "with valid credentials" do
      xit "should return a 200 status response" do
        VCR.use_cassette('.for_tracks check 200 status') do
          response = MessageFetcher.for_tracks(1)
          expect(response.status).to eq 200
        end
      end

      it "should only return messages for the specified track_id" do
        VCR.use_cassette('.for_tracks check track_id') do
          messages = MessageFetcher.for_tracks(1)
          expect(messages.first["track_id"]).to eq 1
          expect(messages.last["track_id"]).to eq 1
        end
      end
    end

    context "with invalid credentials" do
      xit "raises an InvalidCredentials error if track_id is not an integer" do
        expect { MessageFetcher.for_tracks("reem") }.to raise_error InvalidCredentials
      end
    end
  end

  describe ".create_message" do
    context "with valid credentials" do
      xit "should return a 201 status response" do
        VCR.use_cassette('.create_message check status') do
          data = { body: "Hello world", user_id: 3, track_id: 2}
          response = MessageFetcher.create_message(data)
          expect(response.status).to eq 201
        end
      end

      it "should return the created message in json format" do
        VCR.use_cassette('.create_message check reponse') do
          data = { body: "Hello world", user_id: 3, track_id: 2}
          message = MessageFetcher.create_message(data)
          expect(message["body"]).to eq "Hello world"
          expect(message["user_id"]).to eq 3
          expect(message["track_id"]).to eq 2
        end
      end
    end

    context "with invalid credentials" do

      xit "raise an InvalidCredentials error if any of parameters are missing" do
        data = {}
        expect{ MessageFetcher.create_message(data) }.to raise_error(InvalidCredentials)
      end

      xit "raises an InvalidCredentials error if track_id is not an integer" do
        data = {track_id: "katrina", user_id: 1, body: "hello"}
        expect{ MessageFetcher.create_message(data) }.to raise_error(InvalidCredentials)
      end
      xit "raises an InvalidCredentials error if user_id is not an integer" do
        data = {track_id: 1, user_id: "hello", body: "hello"}
        expect{ MessageFetcher.create_message(data) }.to raise_error(InvalidCredentials)
      end
      xit "raises an InvalidCredentials error if message body is missing" do
        data = {track_id: 1, user_id: 2, body: ""}
        expect{ MessageFetcher.create_message(data) }.to raise_error(InvalidCredentials)
      end
    end
  end
end
