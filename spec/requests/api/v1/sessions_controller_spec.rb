# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Api::V1::SessionsController", type: :request do
  describe "GET /api/v1/sessions/:id" do
    subject(:request) { get "/api/v1/sessions/#{session.id}" }

    let(:session) { create(:session) }

    it 'returns a session' do
      request

      expect(response).to have_http_status(:success)
      expect(response.body).to eq(session.to_json)
    end
  end

  describe "POST /api/v1/sessions" do
    subject(:request) { post "/api/v1/sessions", params: { session: session_params } }

    let(:game) { create(:game) }
    let(:player) { create(:player) }
    let(:session_params) { { game_id: game.id, player_id: player.id } }

    it 'creates a session' do
      expect { request }.to change { Session.count }.by(1)
      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq(Session.last.as_json)
    end
  end

  describe "PATCH /api/v1/sessions/:id/start" do
    subject(:request) { patch "/api/v1/sessions/#{session.id}/start" }

    let(:session) { create(:session) }

    it 'starts a session' do
      expect { request }.to change { session.reload.state }.to('in_progress')

      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /api/v1/sessions/:id/finish" do
    subject(:request) { patch "/api/v1/sessions/#{session.id}/finish" }

    let(:session) { create(:session, :in_progress) }

    it 'finishes a session' do
      expect { request }.to change { session.reload.state }.to('finished')

      expect(response).to have_http_status(:success)
    end
  end
end
