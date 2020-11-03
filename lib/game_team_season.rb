require_relative './game_team'
require_relative './game_team_collection'
require_relative "./divisable"

class GameTeamSeason < GameTeamCollection
  include Divisable
  def games_in_season(season)
    @game_teams.select do |game|
    @stat_tracker.game_ids_per_season[season].include?(game.game_id)
    end
  end

  def games_per_coach(season)
    coaches_and_games = {}
    games_in_season(season).each do |game|
     (coaches_and_games[game.head_coach] << game if coaches_and_games[game.head_coach]) ||
     (coaches_and_games[game.head_coach] = [game])
     end
    coaches_and_games
  end

  def count_coach_results(season)
    coaches_and_results = {}
    games_per_coach(season).each do |coach, games|
        coaches_and_results[coach] = games.count do |game|
        game.result == "WIN"
      end
    end
    coaches_and_results
  end

  def coach_percentage(season)
    coaches_and_percentages = {}
    wins ||= count_coach_results(season)
    wins.keys.map do |coach|
      coaches_and_percentages[coach] = average(wins[coach].to_f, games_per_coach(season)[coach].count)
    end
    coaches_and_percentages
  end

  def winningest_coach(season)
    coach = coach_percentage(season).max_by do |coach, percentage|
      percentage
    end
    coach[0]
  end

  def worst_coach(season)
    coach = coach_percentage(season).min_by do |coach, percentage|
      percentage
    end
    coach[0]
  end

  def team_scores(season, attribute)
    scores = {}
    games_in_season(season).each do |game|
      if attribute == "shots"
        (scores[game.team_id] += game.shots.to_i if scores[game.team_id]) ||
        (scores[game.team_id] = game.shots.to_i)
      elsif attribute == "goals"
        (scores[game.team_id] += game.goals.to_i if scores[game.team_id]) ||
        (scores[game.team_id] = game.goals.to_i)
      end
    end
    scores
  end

  def team_ratios(season)
    goals = team_scores(season, "goals")
    shots = team_scores(season, "shots")
    score_ratios = {}
    ratios = count_coach_results(season)
    goals.keys.each do |team_id|
      score_ratios[team_id] = average(goals[team_id].to_f, shots[team_id])
    end
    score_ratios
  end

  def most_accurate_team(season)
    team_id = team_ratios(season).max_by do |team, ratio|
      ratio
    end
    @stat_tracker.find_team_name(team_id[0])
  end

  def least_accurate_team(season)
    team_id = team_ratios(season).min_by do |team, ratio|
      ratio
    end
    @stat_tracker.find_team_name(team_id[0])
  end

  def total_tackles(season)
    teams_tackles = {}
    games_in_season(season).each do |game|
      (teams_tackles[game.team_id] += game.tackles.to_i if teams_tackles[game.team_id]) ||
      (teams_tackles[game.team_id] = game.tackles.to_i)
    end
    teams_tackles
  end

  def most_tackles(season)
    team_id = total_tackles(season).max_by do |team, tackles|
     tackles
   end
    @stat_tracker.find_team_name(team_id[0])
  end

  def least_tackles(season)
    team_id = total_tackles(season).min_by do |team, tackles|
     tackles
    end
    @stat_tracker.find_team_name(team_id[0])
  end

end
