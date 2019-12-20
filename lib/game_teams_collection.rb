require_relative "game_teams"
require_relative 'csv_loadable'

class GameTeamsCollection
  include CsvLoadable

  attr_reader :game_teams_array

  def initialize(file_path)
    @game_teams_array = create_game_teams_array(file_path)
  end

  def create_game_teams_array(file_path)
    load_from_csv(file_path, GameTeams)
  end
  # require "pry"; binding.pry
end



  def game_teams_by_id

    hash.keys.reduce({}) do |new_hash, key|
      new_hash[key] = hash[key].find_home_games
    end

  end

  def find_home_games
    game_teams_lists_by_id[team_id].find_all do |game_teams|
      game_teams.hoa == "home"
    end
  end
