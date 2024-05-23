# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::GamesControllers", type: :request do
  describe "GET /api/v1/games" do
    subject(:request) { get "/api/v1/games" }

    let!(:games) { create_list(:game, 3) }

    it "returns a list of games" do
      request

      expect(response).to have_http_status(:success)
      expect(response.body).to eq(games.to_json)
    end
  end
end
