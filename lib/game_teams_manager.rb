require_relative './mathable'
require_relative './game_team'
require 'CSV'

class GameTeamsManager
  include Mathable
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
    accuracy = Hash.new { |accuracy, key| accuracy[key] = [0,0] }
    @game_teams.each do |game_team|
      if season_games_ids.include?(game_team.game_id)
        accuracy[game_team.team_id][0] += game_team.goals
        accuracy[game_team.team_id][1] += game_team.shots
      end
    end
    accuracy
  end

  def score_ratios_hash(season_games_ids)
    ratio = score_and_shots_by_team(season_games_ids)
    ratio.transform_values {|pair| calculate_ratios(pair)}
  end

  def calculate_ratios(pair)
    pair.first.to_f / pair.last.to_f
  end

  def winningest_coach(season_games)
    coach = Hash.new { |coach, team| coach[team] = [0,0] }
    @game_teams.each do |game_team|
      if season_games.include?(game_team.game_id)
        coach[game_team.head_coach][1] += 1
        coach[game_team.head_coach][0] += 1 if game_team.result == "WIN"
      end
    end
    coach.each do |team_id, pair|
      coach[team_id] = calculate_ratios(pair)
    end
    coach.key(coach.values.max)
  end

  def worst_coach(season_games)
    coach = Hash.new { |hash, team| hash[team] = [0,0] }
    @game_teams.each do |game_team|
      if season_games.include?(game_team.game_id)
        coach[game_team.head_coach][1] += 1
        coach[game_team.head_coach][0] += 1 if game_team.result == "WIN"
      end
    end
    coach.each do |team_id, pair|
      coach[team_id] = calculate_ratios(pair)
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
    goals_by_team_id = Hash.new(0)
    game_teams.each do |game|
      goals_by_team_id[game.team_id] += game.goals
    end
    goals_by_team_id
  end

  def total_games_by_team
    games_by_team_id = Hash.new(0)
    game_teams.each do |game|
      games_by_team_id[game.team_id] += 1
    end
    games_by_team_id
  end

  def best_offense
    averages = total_goals_by_team.merge(total_games_by_team) do |team_id, goals, games|
      to_percent(goals, games)
    end
    averages.max_by {|team_id, average| average}.first
  end

  def worst_offense
    averages = total_goals_by_team.merge(total_games_by_team) do |team_id, goals, games|
      to_percent(goals, games)
    end
    averages.min_by {|team_id, average| average}.first
  end
end
