# frozen_string_literal: true

require "rails_helper"

RSpec.describe Gameplay::Slot do
  subject(:game) { described_class.new(session) }

  shared_context "when session in a state" do |state, method, error_class, error_message|
    let(:session) { create(:session, state) }

    it "raises #{error_class} error" do
      expect { game.public_send(method) }.to raise_error(error_class) do |e|
        expect(e.message).to eq(error_message) if error_message
      end
    end
  end

  describe "#start!" do
    let(:session) { create(:session) }

    it "moves session to in_progress state" do
      game.start!

      expect(session.state).to eq("in_progress")
    end

    context "when session is finished" do
      include_context "when session in a state", :finished, :start!, Gameplay::Errors::FinishedSession
    end

    context "when session is lost" do
      include_context "when session in a state", :lost, :start!, Gameplay::Errors::FinishedSession
    end

    context "when session is won" do
      include_context "when session in a state", :won, :start!, Gameplay::Errors::FinishedSession
    end
  end

  describe "#finish!" do
    let(:session) { create(:session) }

    it "moves session to in_progress state" do
      game.finish!

      expect(session.state).to eq("finished")
    end

    context "when session is finished" do
      include_context "when session in a state", :finished, :finish!, Gameplay::Errors::FinishedSession, "Game is finished already"
    end

    context "when session is won" do
      include_context "when session in a state", :won, :finish!, Gameplay::Errors::FinishedSession, "Game is finished already"
    end

    context "when session is lost" do
      include_context "when session in a state", :lost, :finish!, Gameplay::Errors::FinishedSession, "Game is finished already"
    end
  end

  describe "#play!" do
    let(:session) { create(:session, :in_progress, score: 100) }

    it "raises NotImplementedError" do
      expect { game.play! }.to raise_error(NotImplementedError)
    end

    context "when session is new" do
      include_context "when session in a state", :new, :play!, Gameplay::Errors::InactiveSession
    end

    context "when session is finished" do
      include_context "when session in a state", :finished, :play!, Gameplay::Errors::FinishedSession
    end

    context "when session is won" do
      include_context "when session in a state", :won, :play!, Gameplay::Errors::FinishedSession
    end

    context "when session is lost" do
      include_context "when session in a state", :lost, :play!, Gameplay::Errors::FinishedSession
    end
  end

  describe "#cash_out!" do
    let(:session) { create(:session, :in_progress, score: 100) }

    it "moves session to won state and moves score to player credit" do
      expect { game.cash_out! }.to change { session.player.credits }.by(100).and change { session.state }.to("won")
    end

    context "when session is finished" do
      include_context "when session in a state", :finished, :cash_out!, Gameplay::Errors::FinishedSession, "You can't cash out lost or finished sessions"
    end

    context "when session is won" do
      include_context "when session in a state", :won, :cash_out!, Gameplay::Errors::FinishedSession, "You can't cash out lost or finished sessions"
    end

    context "when session is lost" do
      include_context "when session in a state", :lost, :cash_out!, Gameplay::Errors::FinishedSession, "You can't cash out lost or finished sessions"
    end
  end

  describe "#top_up!" do
    let(:session) { create(:session, :in_progress, score: 100) }

    it "tops up session score" do
      expect { game.top_up! }.to change { session.score }.by(100)
    end

    context "when session is finished" do
      include_context "when session in a state", :finished, :top_up!, Gameplay::Errors::FinishedSession, "You can't top up lost or finished sessions"
    end

    context "when session is won" do
      include_context "when session in a state", :won, :top_up!, Gameplay::Errors::FinishedSession, "You can't top up lost or finished sessions"
    end

    context "when session is lost" do
      include_context "when session in a state", :lost, :top_up!, Gameplay::Errors::FinishedSession, "You can't top up lost or finished sessions"
    end
  end
end
