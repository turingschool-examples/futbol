require_relative 'collection'
require_relative 'game_stats'
require_relative 'team'
require_relative 'modules/listable'

class SeasonStats < Collection
  include Listable
  attr_reader :teams, :game_stats

  def initialize(teams_path, game_stats_path)
    @teams = create_objects(teams_path, Team)
    @game_stats = create_objects(game_stats_path, GameStats)
  end

  def season_stat_percentage(season, team_type, stat_type)
    results_tracker = {:denominator => 0, :numerator => 0}
    games = games_by_season(season, @game_stats)
    games.each do |game|
      if stat_type == :win
        if game.head_coach == team_type && game.result == "WIN"
          results_tracker[:denominator] += 1
          results_tracker[:numerator] += 1
        elsif game.head_coach == team_type
          results_tracker[:denominator] += 1
        end
      elsif stat_type == :shot
        if game.team_id == team_type
          results_tracker[:denominator] += game.shots
          results_tracker[:numerator] += game.goals
        end
      end
    end
    (results_tracker[:numerator].to_f / results_tracker[:denominator])
  end

  def winningest_coach(season)
    games = games_by_season(season, @game_stats)
    wins = team_wins_by_season(games)
    coach_names = coaches_by_season(games)
    percentage_tracker = -1
    name_tracker = nil
    coach_names.each do |name|
      percentage = season_stat_percentage(season, name, :win)
      if percentage > percentage_tracker
        percentage_tracker = percentage
        name_tracker = name
      end
    end
    name_tracker
  end

  def worst_coach(season)
    games = games_by_season(season, @game_stats)
    coach_names = coaches_by_season(games)

    percentage_tracker = 2
    name_tracker = nil
    coach_names.each do |name|
      percentage = season_stat_percentage(season, name, :win)
      if percentage < percentage_tracker
        percentage_tracker = percentage
        name_tracker = name
      end
    end
    name_tracker
  end

  def most_accurate_team(season)
    games = games_by_season(season, @game_stats)
    team_ids = team_ids_by_season(games)
    shots = team_shots_by_season(games)
    goals = team_goals_by_season(games)
    id_tracker = nil
    percent_tracker = 0
    team_ids.each do |id|
      result = goals[id].to_f / shots[id]
      if result > percent_tracker
        percent_tracker = result
        id_tracker = id
      end
    end
    @teams.find{|team| team.team_id == id_tracker}.teamname
  end

  def least_accurate_team(season)
    games = games_by_season(season, @game_stats)
    team_ids = team_ids_by_season(games)
    shots = team_shots_by_season(games)
    goals = team_goals_by_season(games)
    id_tracker = nil
    percentage_tracker = 2
    team_ids.each do |id|
      percentage = goals[id].to_f / shots[id]
      if percentage < percentage_tracker
        percentage_tracker = percentage
        id_tracker = id
      end
    end
    @teams.find{|team| team.team_id == id_tracker}.teamname
  end

  def most_tackles(season)
    games = games_by_season(season, @game_stats)
    teams_tackles = team_tackles_by_season(games)
    id = teams_tackles.sort_by {|id, tackles| tackles}.last[0]
    @teams.find{|team| team.team_id == id}.teamname
  end

  def fewest_tackles(season)
    games = games_by_season(season, @game_stats)
    teams_tackles = team_tackles_by_season(games)
    id = teams_tackles.sort_by {|id, tackles| tackles}.first[0]
    @teams.find{|team| team.team_id == id}.teamname
  end
end
