module Api
  module V1
    class PlayersController < ApplicationController
      skip_before_action :verify_authenticity_token

      def show
        render json: player
      end

      def create
        # For not simply create a player
        # In future it's necessary to verify age and T&C

        render json: Player.create(player_params)
      end

      def update
        player.update(player_params)

        render json: player
      end

      private

      def player_params
        params.require(:player).permit(:id, :nick)
      end

      def player
        @player ||= Player.find(params[:id])
      end
    end
  end
end
