# frozen_string_literal: true

namespace :casino do
  desc "Create games"
  task create_games: :environment do
    Rails.logger.info("Creating games...")

    Rails.logger.debug("Frutt-Tutty game creation...")
    # TODO: Default credits should be store somewhere like config yml or .env
    Game.find_or_create_by!(name: "Frutty-Tutty", kind: "slots", credits: 10)
    Rails.logger.debug("Frutt-Tutty game created...")

    Rails.logger.info("Created games")
  end
end
