# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Gameplay::Games::FruttyTutty do
  subject(:gameplay) { described_class.new(session) }

  let(:game) { create(:game, :frutty_tutty) }

  describe '#start!' do
    let(:session) { create(:session, game:) }
    let(:free_credits) { 10 }

    it 'adds free credits to the session' do
      expect { gameplay.start! }.to change { session.score }.by(free_credits)
    end
  end

  describe '#play!' do
    let(:session) { create(:session, :in_progress, score: 10, game:) }
    let(:expected_sequence) { %w[🍒 🍋 🍊] }
    let(:expected_score) { 9 }
    let(:expected_reward) { 0 }
    let(:expected_result) { { sequence: expected_sequence, reward: expected_reward, score: expected_score } }

    before do
      allow(gameplay).to receive(:reroll?).and_return(false)
      allow(gameplay).to receive(:sequence).and_return(expected_sequence)
    end

    it 'generates a sequence of slots, calculates reward, updates the session score' do
      expect { expect(gameplay.play!).to eq(expected_result) }.to change { session.score }.by(-1)
    end

    context 'when generated sequence of lemons' do
      let(:expected_sequence) { %w[🍒 🍒 🍒] }
      let(:expected_reward) { 10 }
      let(:expected_score) { 20 }

      it 'generates a sequence of slots, calculates reward, updates the session score' do
        expect { expect(gameplay.play!).to eq(expected_result) }.to change { session.score }.by(expected_reward)
      end
    end

    context 'when generated sequence of lemons' do
      let(:expected_sequence) { %w[🍋 🍋 🍋] }
      let(:expected_reward) { 20 }
      let(:expected_score) { 30 }

      it 'generates a sequence of slots, calculates reward, updates the session score' do
        expect { expect(gameplay.play!).to eq(expected_result) }.to change { session.score }.by(expected_reward)
      end
    end

    context 'when generated sequence of cherries' do
      let(:expected_sequence) { %w[🍊 🍊 🍊] }
      let(:expected_reward) { 30 }
      let(:expected_score) { 40 }

      it 'generates a sequence of slots, calculates reward, updates the session score' do
        expect { expect(gameplay.play!).to eq(expected_result) }.to change { session.score }.by(expected_reward)
      end
    end

    context 'when generated sequence of cherries' do
      let(:expected_sequence) { %w[🍉 🍉 🍉] }
      let(:expected_reward) { 40 }
      let(:expected_score) { 50 }

      it 'generates a sequence of slots, calculates reward, updates the session score' do
        expect { expect(gameplay.play!).to eq(expected_result) }.to change { session.score }.by(expected_reward)
      end
    end
  end

  describe 'rerolling' do
    let(:expected_sequence) { %w[🍒 🍋 🍊] }
    let(:session) { create(:session, :in_progress, score: 10, game:) }

    before do
      allow(gameplay).to receive(:sequence).and_return(expected_sequence)
    end

    it 'does not reroll if not winning roll' do
      expect(gameplay).to_not receive(:reroll)

      gameplay.play!
    end

    context 'when session score is less or eqaul 40' do
      let(:session) { create(:session, :in_progress, score: 40) }
      let(:expected_sequence) { %w[🍒 🍒 🍒] }

      it 'does not reroll' do
        expect(gameplay).not_to receive(:reroll)

        gameplay.play!
      end
    end

    context 'when session score is greater than 40 and less or equal 60' do
      let(:session) { create(:session, :in_progress, score: 60) }
      let(:expected_sequence) { %w[🍒 🍒 🍒] }

      before do
        allow(gameplay).to receive(:reroll_with_chance_30?).and_return(true)
      end

      it 'rerolls with 30% chance' do
        expect(gameplay).to_not receive(:reroll_with_chance_60?)
        expect(gameplay).to receive(:reroll)

        gameplay.play!
      end
    end

    context 'when session score is greater than 60' do
      let(:session) { create(:session, :in_progress, score: 61) }
      let(:expected_sequence) { %w[🍒 🍒 🍒] }

      before do
        allow(gameplay).to receive(:reroll_with_chance_60?).and_return(true)
      end

      it 'rerolls with 60% chance' do
        expect(gameplay).to_not receive(:reroll_with_chance_30?)
        expect(gameplay).to receive(:reroll)

        gameplay.play!
      end
    end
  end
end
