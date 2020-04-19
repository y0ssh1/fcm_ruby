# frozen_string_literal: true

require 'webmock/rspec'

RSpec.describe FcmRuby do
  describe 'sending notification' do
    let(:api_token) { 'alksdjflajdennwsewnklnkxl' }
    let(:project_id) { '123456789' }
    let(:authorization) { "Bearer #{api_token}" }
    let(:message) { { data: { sample: 'data' } } }

    context 'when message is an Array' do
      let(:end_point) { 'https://fcm.googleapis.com/batch' }
      let(:messages) { Array.new(3) { |_| message } }
      before do
        stub_request(:post, end_point).to_return(status: 200)
      end

      it 'success to post message' do
        client = FcmRuby.new(api_token, project_id)
        client.send(messages).status.should eq 200
      end
    end

    context 'when message is a hash' do
      let(:end_point) { "https://fcm.googleapis.com/v1/projects/#{project_id}/messages:send" }
      before do
        stub_request(:post, end_point).to_return(status: 200)
      end

      it 'success to post message' do
        client = FcmRuby.new(api_token, project_id)
        client.send(message).status.should eq 200
      end
    end
  end
end
