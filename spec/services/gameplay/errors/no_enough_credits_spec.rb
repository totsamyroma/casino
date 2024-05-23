# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Gameplay::Errors::NotEnoughCredits do
  subject(:error) { described_class }

  let(:error_message) { "You don't have enough credits to play. Start a new game." }

  it 'has expected error message' do
    expect { raise error }.to raise_error do |e|
      expect(e.message).to eq(error_message)
    end
  end
end
