require './lib/stat_tracker'
require './renameable'

class SeasonStatistics
  include Renameable
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games      = games
    @teams      = teams
    @game_teams = game_teams
  end

  def total_shots(season)
    hash_generator(@game_teams, :team_id, :shots, season)
  end

  def most_accurate_team(season)
    goals_by_team = hash_generator(@game_teams, :team_id, :goals, season)

    accuracy = goals_by_team.max_by do |id, goals|
      tot_goals = total_shots(season)[id]
      goals.fdiv(tot_goals)
    end
    team_identifier(accuracy[0])
  end

  def least_accurate_team(season)
    goals_by_team = hash_generator(@game_teams, :team_id, :goals, season)

    accuracy = goals_by_team.min_by do |id, goals|
      tot_goals = total_shots(season)[id]
      goals.fdiv(tot_goals)
    end
    team_identifier(accuracy[0])
  end

  def total_games_by_coach(season)

    games_by_coach = Hash.new(0)
    @game_teams.each do |game|
      if season_verification(game, season)
        games_by_coach[game.head_coach] += 1
      end
    end
    games_by_coach
  end

  def winningest_coach(season)
    wins_by_coach = Hash.new(0)
    @game_teams.each do |game|
      if season_verification(game, season) && game.result == 'WIN'
        wins_by_coach[game.head_coach] += 1
      end
    end
    coach = wins_by_coach.max_by do |coach, wins|
      tot_games = total_games_by_coach(season)[coach]
      wins.fdiv(tot_games)
    end
    coach[0]
  end

  def worst_coach(season)
    wins_by_coach = total_games_by_coach(season)
    @game_teams.each do |game|
      if season_verification(game, season) && game.result == ("WIN")
        wins_by_coach[game.head_coach] += 1
      end
    end
    loser_coach = wins_by_coach.min_by do |coach, wins|
      tot_games = total_games_by_coach(season)[coach]
      (wins_by_coach[coach] - tot_games).fdiv(tot_games)
    end
    loser_coach[0]
  end

  def most_tackles(season)
    tackles_by_team = hash_generator(@game_teams, :team_id, :tackles, season)
    team_highest = tackles_by_team.max_by do |team_id, tackles|
      tackles
    end
    team_identifier(team_highest[0])
  end

  def fewest_tackles(season)
    tackles_by_team = hash_generator(@game_teams, :team_id, :tackles, season)
    team_highest = tackles_by_team.min_by do |team_id, tackles|
      tackles
    end
    team_identifier(team_highest[0])
  end
end
