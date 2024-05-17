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

        render json: Session.create(session_params)
      end

      def start
        session.play!

        render json: session.save
      end

      def finish
        session.finish!

        render json: session.save
      end

      def cash_out
        # todo move to cashout service

        ApplicationRecord.transaction do
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
    end
  end
end
