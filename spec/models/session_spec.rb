require 'rails_helper'

RSpec.describe Session, type: :model do
  describe 'validations' do
    context 'with valid attributes' do
      subject(:session) { build(:session) }

      it { is_expected.to be_valid }
    end

    context 'when player is missing' do
      subject(:session) { build(:session, player: nil) }

      it { is_expected.to_not be_valid }
    end

    context 'when game is missing' do
      subject(:session) { build(:session, game: nil) }

      it { is_expected.to_not be_valid }
    end
  end

  describe 'relations' do
    subject(:session) { create(:session, player:, game:) }

    let(:player) { create(:player) }
    let(:game) { create(:game) }

    it "has one player and one game" do
      expect(session.player).to eq(player)
      expect(session.game).to eq(game)
    end
  end

  describe 'state machine' do
    subject(:session) { Session.new }

    it "starts in new_game state" do
      expect(session.state).to eq("new_game")
    end

    describe 'available states' do
      subject(:states) { Session.aasm.states.map(&:name) }

      let(:expected_states) { %i(new_game in_progress won lost finished) }

      it { is_expected.to eq(expected_states) }
    end

    describe '#play!' do
      subject(:session) { create(:session) }

      it "transitions to in_progress state" do
        session.play!

        expect(session.state).to eq("in_progress")
      end

      context "when already in in_progress state" do
        before { session.play! }

        it "does not change the state" do
          expect { session.play! }.to raise_error(AASM::InvalidTransition)
        end
      end
    end

    describe '#finisn!' do
      subject(:session) { create(:session) }

      it "transitions to finish state" do
        session.finish!

        expect(session.state).to eq("finished")
      end

      context "when in in_progress state" do
        subject(:session) { create(:session, :in_progress) }

        it "transitions to finish state" do
          session.finish!

          expect(session.state).to eq("finished")
        end
      end

      context "when already in finished state" do
        subject(:session) { create(:session, :won) }

        it "does not change the state" do
          expect { session.finish! }.to raise_error(AASM::InvalidTransition)
        end
      end
    end

    describe '#win!' do
      subject(:session) { create(:session, :in_progress) }

      it "transitions to won state" do
        session.win!

        expect(session.state).to eq("won")
      end

      context "when already in won state" do
        subject(:session) { create(:session, :won) }

        it "does not change the state" do
          expect { session.win! }.to raise_error(AASM::InvalidTransition)
        end
      end
    end

    describe '#lose!' do
      subject(:session) { create(:session, :in_progress) }

      it "transitions to lost state" do
        session.lose!

        expect(session.state).to eq("lost")
      end

      context "when already in won state" do
        subject(:session) { create(:session, :lost) }

        it "does not change the state" do
          expect { session.lose! }.to raise_error(AASM::InvalidTransition)
        end
      end
    end
  end
end
