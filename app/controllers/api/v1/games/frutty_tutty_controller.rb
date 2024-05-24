# frozen_string_literal: true

module Api
  module V1
    module Games
      class FruttyTuttyController < ApplicationController
        skip_before_action :verify_authenticity_token

        def start
          game.start!

          render json: session
        end

        def play
          result = game.play!

          render json: result
        end

        def finish
          game.finish!

          render json: session
        end

        def cash_out
          # TODO: move to cashout service
          # player should not be able to cash out free credits
          game.cash_out!

          render json: session
        end

        def top_up
          # TODO: move to top up service
          game.top_up!(game_params[:top_up_amount])

          render json: session
        end

        private

        def game_params
          params.require(:game).permit(:session_id, :top_up_amount, :player_id)
        end

        def session
          @session ||= Session.find(game_params[:session_id])
        end

        def game
          @game ||= Gameplay::Games::FruttyTutty.new(session)
        end
      end
    end
  end
end
