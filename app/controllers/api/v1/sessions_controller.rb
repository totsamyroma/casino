module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def show
        render json: session
      end

      def create
        # For not simply create a player
        # In future it's necessary to verify age and T&C

        # todo: move to session creator
        # it has to allocate free points in the beginning of the session
        # if a game has one
        session = Session.create(**session_params, score: game.credits)

        render json: session
      end

      def start
        raise Gameplay::Errors::FinishedSession if session.finished? || session.lost? || session.won?

        session.play

        render json: session.save
      end

      def finish
        session.finish

        render json: session.save
      end

      def cash_out
        # todo move to cashout service

        ApplicationRecord.transaction do
          session.finish!
          session.player.update(credits: session.player.credits + session.score)
          session.update(score: 0)
        end

        render json: session
      end

      private

      def session_params

        params.require(:session).permit(:id, :game_id, :player_id)
      end

      def session
        @session ||= Session.find(params[:id])
      end

      def game
        @game ||= Game.find(session_params[:game_id])
      end
    end
  end
end
