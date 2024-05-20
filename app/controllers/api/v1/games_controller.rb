module Api
  module V1
    class GamesController < ApplicationController
      def index
        render json: Game.all
      end
    end
  end
end
