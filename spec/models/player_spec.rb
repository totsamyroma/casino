# frozen_string_literal: true

require "rails_helper"

RSpec.describe Player, type: :model do
  describe "validations" do
    context "with valid attributes" do
      subject(:player) { build(:player) }

      it { is_expected.to be_valid }
    end

    context "when nick is missing" do
      subject(:player) { build(:player, nick: "") }

      it { is_expected.to_not be_valid }
    end

    context "when nick is taken" do
      subject(:player) { build(:player, nick: "Taken") }

      before do
        create(:player, nick: "Taken")
      end

      it { is_expected.to_not be_valid }
    end

    context "when credits is negative" do
      subject(:game) { build(:game, credits: -1) }

      it { is_expected.to_not be_valid }
    end
  end

  describe "relations" do
    subject(:player) { create(:player) }

    let!(:game1) { create(:game) }
    let!(:game2) { create(:game) }

    let!(:session1) { create(:session, player:, game: game1) }
    let!(:session2) { create(:session, player:, game: game2) }

    it "has many games and sessions" do
      expect(player.sessions).to eq([session1, session2])
      expect(player.games).to eq([game1, game2])
    end
  end
end
