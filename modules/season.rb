require './lib/game'
require './lib/game_teams'
require './lib/team_stats'
require 'pry'
# This mod will handle all season related methods
module Season
  def winningest_coach(season)
    outcome = GameTeams.create_list_of_game_teams(@game_teams).find_all { |game| game.result == 'WIN' }
    coach_performance(season, outcome).sort_by { |_coach, wins| wins }.reverse[0][0]
  end

  def games_by_season(season)
    games = Game.create_list_of_games(@games)
    games.find_all { |game| game.season == season }
  end

  def coach_performance(season, outcome)
    games = games_by_season(season)
    result_by_coach = {}
    outcome.each do |result|
      next unless games.any? { |game| game.game_id == result.game_id }

      result_by_coach[result.head_coach] = 1 if result_by_coach[result.head_coach].nil?
      result_by_coach[result.head_coach] += 1
    end
    result_by_coach
  end

  def worst_coach(season)
    outcome = GameTeams.create_list_of_game_teams(@game_teams).find_all { |game| game.result == 'LOSS' }
    coach_performance(season, outcome).sort_by { |_coach, loss| loss }[0][0]
  end

  def most_accurate_team(season)
    teams = TeamStats.create_a_list_of_teams(@teams)
    teams.find { |team| team.team_id == team_accuracy(season)[-1][0] }.team_name
  end

  def team_accuracy(season)
    info = GameTeams.create_list_of_game_teams(@game_teams)
    games = games_by_season(season)
    shots_taken = {}
    goals_made  = {}
    info.each do |team|
      next unless games.any? { |game| game.game_id == team.game_id }

      if shots_taken[team.team_id].nil?
        shots_taken[team.team_id] = team.shots
      else
        shots_taken[team.team_id] += team.shots
      end
      if goals_made[team.team_id].nil?
        goals_made[team.team_id] = team.goals
      else
        goals_made[team.team_id] += team.goals
      end
    end
    team_accuracy = []
    shots_taken.each do |team, shots|
      team_accuracy << [team, goals_made[team].to_f / shots]
    end
    team_accuracy.sort_by { |_team, accuracy| accuracy }
  end

  def least_accurate_team(season)
    teams = TeamStats.create_a_list_of_teams(@teams)
    teams.find { |team| team.team_id == team_accuracy(season)[0][0] }.team_name
  end

  def most_tackles(season)
    teams = TeamStats.create_a_list_of_teams(@teams)
    teams.find { |team| team.team_id == team_tackles(season)[-1][0] }.team_name
  end

  def team_tackles(season)
    info = GameTeams.create_list_of_game_teams(@game_teams)
    games = games_by_season(season)
    tackles_by_team = {}
    info.each do |team|
      next unless games.any? { |game| game.game_id == team.game_id }

      if tackles_by_team[team.team_id].nil?
        tackles_by_team[team.team_id] = team.tackles
      else
        tackles_by_team[team.team_id] += team.tackles
      end
    end
    tackles_by_team.sort_by { |_team, tackles| tackles }
  end

  def fewest_tackles(season)
    teams = TeamStats.create_a_list_of_teams(@teams)
    teams.find { |team| team.team_id == team_tackles(season)[0][0] }.team_name
  end
end
