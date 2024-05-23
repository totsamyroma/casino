# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Api::V1::Games::FruttyTuttyController", type: :request do
  let(:game) { create(:game, :frutty_tutty) }

  describe "PATCH /api/v1/game/frutty_tutty/start" do
    subject(:request) { patch "/api/v1/games/frutty_tutty/start", params: game_params }

    let(:session) { create(:session, game:) }
    let(:game_params) { { game: { session_id: session.id } } }

    it 'starts a session' do
      expect { request }.to change { session.reload.state }.to('in_progress')

      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /api/v1/games/frutty_tutty/finish" do
    subject(:request) { patch "/api/v1/games/frutty_tutty/finish", params: game_params }

    let(:session) { create(:session, :in_progress, game:) }
    let(:game_params) { { game: { session_id: session.id } } }

    it 'finishes a session' do
      expect { request }.to change { session.reload.state }.to('finished')

      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /api/v1/games/frutty_tutty/cash_out" do
    subject(:request) { patch "/api/v1/games/frutty_tutty/cash_out", params: game_params }

    let(:session) { create(:session, :in_progress, score: 50, game:) }
    let(:player) { session.player }
    let(:game_params) { { game: { session_id: session.id } } }

    it 'moves session score to player credits and sets session to a won state' do
      expect { request }.to change { player.reload.credits }.by(50)
        .and change { session.reload.state }.to('won')
        .and change { session.reload.score }.to(0)

      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /api/v1/games/frutty_tutty/top_up" do
    subject(:request) { patch "/api/v1/games/frutty_tutty/top_up", params: game_params }

    let(:session) { create(:session, :in_progress, game:) }
    let(:game_params) { { game: { session_id: session.id, top_up_amount: 100 } } }

    it 'tops up session score' do
      expect { request }.to change { session.reload.score }.by(100)

      expect(session.reload.state).to eq('in_progress')
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /api/v1/games/frutty_tutty/play" do
    subject(:request) { patch "/api/v1/games/frutty_tutty/play", params: game_params }

    let(:session) { create(:session, :in_progress, score: 30, game:) }
    let(:game_params) { { game: { session_id: session.id } } }
    let(:expected_sequence) { %w[🍒 🍒 🍒] }
    let(:expected_restult) { { sequence: expected_sequence, reward: 10, score: 40 } }

    before do
      allow_any_instance_of(Gameplay::Games::FruttyTutty).to receive(:sequence).and_return(expected_sequence)
    end

    it 'tops up session score' do
      expect { request }.to change { session.reload.score }.by(10)

      expect(response).to have_http_status(:success)
    end
  end
end
