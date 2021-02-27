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

  def score_ratios_hash(season_games_ids)   ##Refactor?: 'hash' to 'accuracy'
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

  def winningest_coach(season_games)   ##Refactor?: change 'hash' to 'coach'
    hash = Hash.new { |hash, team| hash[team] = [0,0] }
    @game_teams.each do |game_team|
      if season_games.include?(game_team.game_id)
        hash[game_team.head_coach][1] += 1
        hash[game_team.head_coach][0] += 1 if game_team.result == "WIN"
      end
    end
    hash.each do |team_id, pair|
      ratio = calculate_ratios(pair)
      hash[team_id] = ratio
    end
    hash.key(hash.values.max)
  end

  def worst_coach(season_games)   ##Refactor?:  change 'hash' to 'coach'
    hash = Hash.new { |hash, team| hash[team] = [0,0] }
    @game_teams.each do |game_team|
      if season_games.include?(game_team.game_id)
        hash[game_team.head_coach][1] += 1
        hash[game_team.head_coach][0] += 1 if game_team.result == "WIN"
      end
    end
    hash.each do |team_id, pair|
      ratio = calculate_ratios(pair)
      hash[team_id] = ratio
    end
    hash.key(hash.values.min)
  end

#PSUEDO  def best_season(team_id)
#        METHOD.gets_season_id_games_csv(game_id)
# @games.ea if @games.team_id == team_id
#  'hash'     season[season_id] = [] if nil? & all_season << s_id
#             season[season_id] << result
# end          end                   gives {season_id: [W/L]}
#

end
