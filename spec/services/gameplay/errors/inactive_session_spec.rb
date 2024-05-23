# frozen_string_literal: true

require "rails_helper"

RSpec.describe Gameplay::Errors::InactiveSession do
  subject(:error) { described_class }

  let(:error_message) { "You can't play on an inactive session. Start game to play." }

  it "has expected error message" do
    expect { raise error }.to raise_error do |e|
      expect(e.message).to eq(error_message)
    end
  end
end
