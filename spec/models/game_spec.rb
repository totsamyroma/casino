# frozen_string_literal: true

require "rails_helper"

RSpec.describe Game, type: :model do
  describe "validations" do
    context "with valid attributes" do
      subject(:game) { build(:game) }

      it { is_expected.to be_valid }
    end

    context "when name is missing" do
      subject(:game) { build(:game, name: "") }

      it { is_expected.to_not be_valid }
    end

    context "when name is taken" do
      subject(:game) { build(:game, name: "Taken") }

      before do
        create(:game, name: "Taken")
      end

      it { is_expected.to_not be_valid }
    end

    context "when credits is negative" do
      subject(:game) { build(:game, credits: -1) }

      it { is_expected.to_not be_valid }
    end
  end

  describe "relations" do
    subject(:game) { create(:game) }

    let!(:player1) { create(:player) }
    let!(:player2) { create(:player) }

    let!(:session1) { create(:session, player: player1, game:) }
    let!(:session2) { create(:session, player: player2, game:) }

    it "has many users and sessions" do
      expect(game.sessions).to eq([session1, session2])
      expect(game.players).to eq([player1, player2])
    end
  end
end
