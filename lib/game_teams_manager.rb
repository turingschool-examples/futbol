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
    coach = Hash.new { |hash, team| hash[team] = [0,0] }
    @game_teams.each do |game_team|
      if season_games.include?(game_team.game_id)
        coach[game_team.head_coach][1] += 1
        coach[game_team.head_coach][0] += 1 if game_team.result == "WIN"
      end
    end
    coach.each do |team_id, pair|
      ratio = calculate_ratios(pair)
      coach[team_id] = ratio
    end
    coach.key(coach.values.min)
  end

  def favorite_opponent(team_id)
    rivals = Hash.new { |rivals, team| rivals[team] = [0,0] }
    played = @game_teams.find_all do |game_team|
      team_id == game_team.team_id
    end
    played.each do |game_A|
      opponent_game = @game_teams.find do |game_B|
        game_A.game_id == game_B.game_id && game_A.team_id != game_B.team_id
      end
      rivals[opponent_game.team_id][1] += 1
      rivals[opponent_game.team_id][0] += 1 if opponent_game.result == "WIN"
    end
    rivals.each do |rival, pair|
      rivals[rival] = calculate_ratios(pair)
    end
    rivals.key(rivals.values.min)
  end

  def rival(team_id)
    rivals = Hash.new { |rivals, team| rivals[team] = [0,0] }
    played = @game_teams.find_all do |game_team|
      team_id == game_team.team_id
    end
    played.each do |game_A|
      opponent_game = @game_teams.find do |game_B|
        game_A.game_id == game_B.game_id && game_A.team_id != game_B.team_id
      end
      rivals[opponent_game.team_id][1] += 1
      rivals[opponent_game.team_id][0] += 1 if opponent_game.result == "WIN"
    end
    rivals.each do |rival, pair|
      rivals[rival] = calculate_ratios(pair)
    end
    rivals.key(rivals.values.max)
  end

  def total_goals_by_team
    goals_by_team_id = {}
    game_teams.each do |game| #should this be @game_teams?
      if goals_by_team_id[game.team_id].nil?
        goals_by_team_id[game.team_id] = game.goals
      else
        goals_by_team_id[game.team_id] += game.goals
      end
    end
    goals_by_team_id
  end

  def total_games_by_team
    games_by_team_id = {}
    game_teams.each do |game|
      if games_by_team_id[game.team_id].nil?
        games_by_team_id[game.team_id] = 1
      else
        games_by_team_id[game.team_id] += 1
      end
    end
    games_by_team_id
  end

  def best_offense
    averages = total_goals_by_team.merge(total_games_by_team) do |team_id, goals, games|
      (goals/games.to_f).round(2)
    end
    average_max = averages.max_by do |team_id, average|
      average
    end
     average_max[0]
  end

  def worst_offense
    averages = total_goals_by_team.merge(total_games_by_team) do |team_id, goals, games|
      (goals/games.to_f).round(2)
    end
    average_min = averages.min_by do |team_id, average|
      average
    end
     average_min[0]
  end
end
