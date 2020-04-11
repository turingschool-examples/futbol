require_relative './csv_helper_file'

class SeasonRepository

  attr_reader :games_collection, :games_teams_collection, :teams_collection
  def initialize(game_path, game_team_path, team_path)
    @game_collection = CsvHelper.generate_game_array(game_path)
    @game_team_collection = CsvHelper.generate_game_teams_array(game_team_path)
    @team_collection = CsvHelper.generate_team_array(team_path)
    require 'pry'; binding.pry
  end

  def id_stats
    @game_team_collection.to_h{|game| [[game.game_id], [game.head_coach, game.result]]}
  end
require 'pry'; binding.pry
  def tally_wins
    require 'pry'; binding.pry
    if @games_teams_collection.id_stats
    end
  end






end
