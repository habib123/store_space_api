require 'rails_helper'

RSpec.describe Api::V1::SpacesController, type: :request do
  let!(:space1) { create :space, store: 'store1', price_per_day:1, price_per_week:2, price_per_month:3 }
  let!(:space2) { create :space, store: 'store2' }

  context "data attributes" do
    it "#space properties" do
      get "/api/spaces", {}, API_V1_HEADERS
      expect(response).to match_response_space_schema 'api/v1/space'
    end
  end

  context "price quote for a space" do
    it "query with wrong end date" do
      get "/api/spaces/#{space1.id}/price/01-12-2015/sdas15-02kbhasas", {}, API_V1_HEADERS
      expect(response.code).to eq('200')
      expect(json[:status]).to eq("ArgumentError")
    end

    it "query with right date with different year" do
      get "/api/spaces/#{space1.id}/price/01-12-2015/15-02-2016", {}, API_V1_HEADERS
      expect(response.code).to eq('200')
      expect(json[:price]).to eq('13.0')
    end

    it "query with start_date gater then end_date" do
      get "/api/spaces/#{space1.id}/price/15-02-2016/01-01-2016", {}, API_V1_HEADERS
      expect(response.code).to eq('200')
      expect(json[:status]).to eq('error')
    end
  end

  context "Action" do
    it "#create" do
      post "/api/spaces", {space: {store: 'store3', titel: 'title', size: 23, price_per_day:1, price_per_week:2, price_per_month:3 }}.to_json, API_V1_HEADERS
      expect(response.code).to eq('201')
    end

    it "#show" do
      get "/api/spaces/#{space1.id}", {}, API_V1_HEADERS
      expect(response.code).to eq('200')
      expect(json[:store]).to eq('store1')
    end

    it "#update" do
      put "/api/spaces/#{space1.id}",  { space: {store: 'store4' } }.to_json, API_V1_HEADERS
      expect(response.code).to eq('200')
      expect(json[:store]).to eq('store4')
    end

    it "#delete the store" do
      expect{
         delete "/api/spaces/#{space1.id}", {}, API_V1_HEADERS
       }.to change(Space, :count).by(-1)
    end
  end
end
