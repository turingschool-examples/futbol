require 'csv'
require_relative 'game'
require_relative 'game_team'
require_relative 'team'

class StatTracker
  def initialize()
  end

  def self.from_csv(locations)
    StatTracker.create_items(locations[:games], Game)
    StatTracker.create_items(locations[:game_teams], GameTeam)
    StatTracker.create_items(locations[:teams], Team)
    StatTracker.new()
  end

  def self.create_items(file, item_class)
    csv_options = {
                    headers: true,
                    header_converters: :symbol,
                    converters: :all
                  }
      CSV.foreach(file, csv_options) { |row| item_class.add(item_class.new(row.to_hash)) }
  end

  def find_games_in_season(season)
    season = season.to_i
    Game.all.select do |game_id, game_data|
      game_data.season == season
    end
    require "pry"; binding.pry
  end

  def find_eligible_teams(season)
    Team.all.select do |team_id, team_data|
      require "pry"; binding.pry
      team_data.team_id
    end
    find_games_in_season(season)
    eligible_teams = {}

    #Iterate over each team. Include the team if they played at least one regular season
    #and one post season game.
  end

end
