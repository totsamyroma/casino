# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::PlayersControllers", type: :request do
  describe "GET /api/v1/players/:id" do
    subject(:request) { get "/api/v1/players/#{player.id}" }

    let(:player) { create(:player) }

    it "returns a player" do
      request

      expect(response).to have_http_status(:success)
      expect(response.body).to eq(player.to_json)
    end
  end

  describe "POST /api/v1/players" do
    subject(:request) { post "/api/v1/players", params: { player: player_params } }

    let(:player_params) { attributes_for(:player) }

    it "creates a player" do
      expect { request }.to change { Player.count }.by(1)

      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq(Player.last.as_json)
    end
  end

  describe "PATCH /api/v1/players" do
    subject(:request) { patch "/api/v1/players/#{player.id}", params: { player: player_params } }
    let(:player_params) { { nick: "new" } }
    let(:player) { create(:player, nick: "old") }

    it "updates a player" do
      expect { request }.to change { player.reload.nick }.from("old").to("new")

      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq(player.as_json)
    end
  end
end
