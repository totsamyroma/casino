require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'validations' do
    context 'with valid attributes' do
      subject(:player) { build(:player) }

      it { is_expected.to be_valid }
    end

    context 'when nick is missing' do
      subject(:player) { build(:player, nick: '') }

      it { is_expected.to_not be_valid }
    end

    context 'when nick is taken' do
      subject(:player) { build(:player, nick: "Taken") }

      before do
        create(:player, nick: "Taken")
      end

      it { is_expected.to_not be_valid }
    end
  end
end
