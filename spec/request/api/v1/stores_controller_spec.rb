require 'rails_helper'

RSpec.describe Api::V1::StoresController, type: :request do
  let!(:store1) { FactoryGirl.create :store, title: 'title1' }
  let!(:store2) { FactoryGirl.create :store, title: 'title2' }

  context "data attributes" do
    it "#store properties" do
      get "/api/stores", {}, API_V1_HEADERS
      expect(response).to match_response_store_schema 'api/v1/store'
    end
  end

  context "filter" do
    it "filter with wrong search term" do
      get '/api/stores?title=like:title', {}, API_V1_HEADERS
      expect(response.code).to eq('200')
      expect(json).to eq([])
    end

    it "filter with  correct search term" do
      get '/api/stores?title=like:title1', {}, API_V1_HEADERS
      expect(response.code).to eq('200')
      expect(json[0]["title"]).to eq('title1')
    end
  end

  context "Action" do
    it "#create" do
      post "/api/stores", {store: {title: 'title', city: 'city', street: 'street', spaces_count: 1}}.to_json, API_V1_HEADERS
      expect(response.code).to eq('201')
    end

    it "#show" do
      get "/api/stores/#{store1.id}",  {}, API_V1_HEADERS
      expect(response.code).to eq('200')
      expect(json[:title]).to eq('title1')
    end

    it "#update" do
      put "/api/stores/#{store1.id}", {store: {title: 'title', city: 'city', street: 'street', spaces_count: 1}}.to_json, API_V1_HEADERS
      expect(response.code).to eq('200')
      expect(json[:title]).to eq('title')
    end

    it "#delete the store" do
      expect{
         delete "/api/stores/#{store1.id}", {}, API_V1_HEADERS
       }.to change(Store, :count).by(-1)
    end
  end
end
