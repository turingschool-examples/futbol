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

  def create_coach_hash(season_games)
    coach_hash = Hash.new { |coach, team| coach[team] = [0,0] }
    @game_teams.each do |game_team|
      if season_games.include?(game_team.game_id)
        coach_hash[game_team.head_coach][1] += 1
        coach_hash[game_team.head_coach][0] += 1 if game_team.result == "WIN"
      end
    end
    coach_hash
  end

  def create_ratio_hash(hash)
    hash.each do |key, pair|
      hash[key] = calculate_ratios(pair)
    end
  end

  def winningest_coach(season_games)
    coach_pairs = create_coach_hash(season_games)
    coach_ratio = create_ratio_hash(coach_pairs)
    coach_ratio.key(coach_ratio.values.max)
  end

  def worst_coach(season_games)
    coach_pairs = create_coach_hash(season_games)
    coach_ratio = create_ratio_hash(coach_pairs)
    coach_ratio.key(coach_ratio.values.min)
  end

  def get_hash_of_rival_teams(team_id)
    rivals = Hash.new { |rivals, team| rivals[team] = [0,0] }
    played = @game_teams.find_all do |game_team|
      team_id == game_team.team_id
    end
    played.each do |game_a|
      opponent_game = @game_teams.find do |game_b|
        game_a.is_game_pair?(game_b)
      end
      rivals[opponent_game.team_id][1] += 1
      rivals[opponent_game.team_id][0] += 1 if opponent_game.result == "WIN"
    end
    rivals
  end

  def favorite_opponent(team_id)
    rival_hash = get_hash_of_rival_teams(team_id)
    rival_hash_ratio = create_ratio_hash(rival_hash)
    rival_hash_ratio.key(rival_hash_ratio.values.min)
  end

  def rival(team_id)
    rival_hash = get_hash_of_rival_teams(team_id)
    rival_hash_ratio = create_ratio_hash(rival_hash)
    rival_hash_ratio.key(rival_hash_ratio.values.max)
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
