require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'validations' do
    context 'with valid attributes' do
      subject(:game) { build(:game) }

      it { is_expected.to be_valid }
    end

    context 'when name is missing' do
      subject(:game) { build(:game, name: '') }

      it { is_expected.to_not be_valid }
    end

    context 'when name is taken' do
      subject(:game) { build(:game, name: "Taken") }

      before do
        create(:game, name: "Taken")
      end

      it { is_expected.to_not be_valid }
    end

    context 'when credits is negative' do
      subject(:game) { build(:game, credits: -1) }

      it { is_expected.to_not be_valid }
    end
  end
end
