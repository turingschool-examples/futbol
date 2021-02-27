require_relative './game_team'
require 'CSV'


class GameTeamsManager
  attr_reader :game_teams

  def initialize(data_path)
    @game_teams = generate_list(data_path)
  end

  def generate_list(data_path)
    list_of_data = []
    CSV.foreach(data_path, headers: true, header_converters: :symbol) do |row|
      list_of_data << GameTeam.new(row)
    end
    list_of_data
  end

  def get_team_tackle_hash(season_games_ids)
    team_tackles_totals = Hash.new(0)
    @game_teams.each do |game_team|
      if season_games_ids.include?(game_team.game_id)
        team_tackles_totals[game_team.team_id] += game_team.tackles
      end
    end
    team_tackles_totals
  end

  def score_and_shots_by_team(season_games_ids)
    hash = Hash.new { |hash, key| hash[key] = [0,0] }
    @game_teams.each do |game_team|
      if season_games_ids.include?(game_team.game_id)
        hash[game_team.team_id][0] += game_team.goals
        hash[game_team.team_id][1] += game_team.shots
      end
    end
    hash
  end

  def score_ratios_hash(season_games_ids)
    hash = score_and_shots_by_team(season_games_ids)
    hash.each do |team_id, pair|
      ratio = calculate_ratios(pair)
      hash[team_id] = ratio
    end
    hash
  end

  def calculate_ratios(pair)
    pair[0].to_f/pair[1].to_f
  end

end
