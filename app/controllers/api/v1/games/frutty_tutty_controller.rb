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
          game.cash_out!

          render json: session
        end

        def top_up
          game.top_up!(game_params[:top_up_amount])

          render json: session
        end

        private

        def game_params
          params.require(:game).permit(:session_id, :top_up_amount)
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