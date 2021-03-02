require_relative './readable'
require_relative './mathable'
require_relative './game_team'
require 'CSV'

class GameTeamsManager
  include Readable
  include Mathable
  attr_reader :game_teams

  def initialize(data_path)
    @game_teams = generate_list(data_path, GameTeam)
  end

  def most_tackles(season)
    tackle_hash = get_team_tackle_hash(season)
    tackle_hash.key(tackle_hash.values.max)
  end

  def fewest_tackles(season)
    tackle_hash = get_team_tackle_hash(season)
    tackle_hash.key(tackle_hash.values.min)
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

  def most_accurate_team(season)
    score_ratios = score_and_shots_by_team(season)
    score_ratios.key(score_ratios.values.max)
  end

  def least_accurate_team(season)
    score_ratios = score_and_shots_by_team(season)
    score_ratios.key(score_ratios.values.min)
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
    create_ratio_hash(ratio)
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
    hash.transform_values {|pair| to_percent(pair[0], pair[1])}
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
      rival_game = @game_teams.find do |game_b|
        game_a.is_game_pair?(game_b)
      end
      rivals[rival_game.team_id][1] += 1
      rivals[rival_game.team_id][0] += 1 if rival_game.result == "WIN"
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
