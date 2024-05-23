# frozen_string_literal: true

namespace :casino do
  desc "Create games"
  task :create_games => :environment do
    Rails.logger.info("Creating games...")

    Rails.logger.debug("Frutt-Tutty game creation...")
    Game.find_or_create_by!(name: "Frutty-Tutty", kind: "slots", credits: Game::CREDITS[:frutty_tutty])
    Rails.logger.debug("Frutt-Tutty game created...")

    Rails.logger.info("Creating games")
  end
end
