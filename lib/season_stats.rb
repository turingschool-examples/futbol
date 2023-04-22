require_relative 'futbol'

class SeasonStats < Futbol

  def initialize(locations)
    super(locations)
  end

  def num_coach_wins(season)
    num_coach_wins = Hash.new
    @games.map do |game|
      if game.season == season
          num_coach_wins[game.home_head_coach] = 0
          num_coach_wins[game.away_head_coach] = 0
      end
    end
  end

  def winningest_coach(season)
    num_coach_wins = Hash.new(0)
    @games.map do |game|
      if game.home_result == "WIN" && game.season == season
        num_coach_wins[game.home_head_coach] += 1
      elsif
        game.away_result == "WIN" && game.season == season
        num_coach_wins[game.away_head_coach] += 1
      end
    end
    num_coach_wins.max_by do |coach, wins|
      wins
    end.first
  end

  def worst_coach(season)
    num_coach_losses = Hash.new(0)
    @games.map do |game|
      if game.home_result == "LOSS" && game.season == season
        num_coach_losses[game.home_head_coach] += 1
      elsif
        game.away_result == "LOSS" && game.season == season
        num_coach_losses[game.away_head_coach] += 1
      end
    end
    require 'pry'; binding.pry
      num_coach_losses.each_pair do |coach, losses|
      losses.to_f / head_coach_games(coach)
    end
  end

  def head_coach_games(coach, season)
    games.count do |game|
      game.season == season && (game.home_head_coach == coach || game.away_head_coach == coach)
    end
  end

  def most_accurate_team(season)
    return invalid_season if season_not_found?(season)
    team = games.select do |game|
      game.team_id == team_id_best_shot_ratio(season)
    end
    team.first.team_name
  end

  def least_accurate_team(season)
    return invalid_season if season_not_found?(season)
    team = games.select do |game|
      game.team_id == team_id_worst_shot_ratio(season)
    end
    team.first.team_name
  end

  # Helpers for accuracy stats
  def season_not_found?(season)
    seasons = @games.map(&:season)
    !seasons.include?(season)
  end
  
  def invalid_season
    'Season Not Found'
  end
  
  def all_goals_by_team_by_season(season)
    team_goals_season = Hash.new(0)
    @games.each do |game|
      if game.season == season
        team_goals_season[game.home_team_id] += game.home_goals.to_i
        team_goals_season[game.away_team_id] += game.away_goals.to_i
      end
    end
    team_goals_season
  end
      
  def all_shots_by_team_by_season(season)
    team_shots_season = Hash.new(0)
    @games.each do |game|
      if game.season == season
      team_shots_season[game.home_team_id] += game.home_shots.to_i
      team_shots_season[game.away_team_id] += game.away_shots.to_i
      end
    end
    team_shots_season
  end

  def teams_shot_ratio(season)
    team_ids = [game.home_team_id, game.away_team_id]
    team_goals = all_goals_by_team_by_season(season)
    team_shots = all_shots_by_team_by_season(season)
    team_goals.merge(team_shots) do |team_id, goals, shots|
      if team_ids.include?(team_id)
        goals.fdiv(shots)
      else
        0
      end
    end
  end

  def best_shot_ratio_team_id(season)
    team_id = teams_shot_ratio(season).max_by {|_, percentage| percentage}
    team_id.first
  end

  def worst_shot_ratio_team_id(season)
    team_id = teams_shot_ratio(season).min_by {|_, percentage| percentage}
    team_id.first
  end
  
  def num_team_tackles(season)
    num_team_tackles = Hash.new(0)
    @games.map do |game|
      if game.season == season
        num_team_tackles[game.home_team_name] += game.home_tackles 
        num_team_tackles[game.away_team_name] += game.away_tackles
      end
    end
    num_team_tackles
  end

  def most_tackles(season)
    num_team_tackles(season).max_by do |name, tackles|
      tackles
    end.first
  end

  def fewest_tackles(season)
    num_team_tackles(season).min_by do |name, tackles|
      tackles
    end.first
  end
end