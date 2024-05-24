# frozen_string_literal: true

require "rails_helper"

RSpec.describe Gameplay::Errors::UnplayedSessionCashOut do
  subject(:error) { described_class }

  let(:error_message) { "You can't cash out credits on unplayed session. Make at least one roll." }

  it "has expected error message" do
    expect { raise error }.to raise_error do |e|
      expect(e.message).to eq(error_message)
    end
  end
end
