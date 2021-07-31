require './lib/stat_tracker'

class SeasonStatistics
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games      = games
    @teams      = teams
    @game_teams = game_teams
  end

  def team_identifier(id)
    matching_team =
    @teams.find do |team|
      team.team_id == id
    end
    matching_team.team_name
  end

  def total_shots(season)
    shots_by_team = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten)
        shots_by_team[game.team_id] += game.shots.to_i
      end
    end
    shots_by_team
  end

  def most_accurate_team(season)
    goals_by_team = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten)
        goals_by_team[game.team_id] += game.goals.to_i
      end
    end
    accuracy =
      goals_by_team.max_by do |id, goals|
      tot_goals = total_shots(season)[id]
      goals.fdiv(tot_goals)
    end
    team_identifier(accuracy[0])
  end

  def least_accurate_team(season)
    goals_by_team = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten)
        goals_by_team[game.team_id] += game.goals.to_i
      end
    end
    accuracy =
      goals_by_team.min_by do |id, goals|
      tot_goals = total_shots(season)[id]
      goals.fdiv(tot_goals)
    end
    team_identifier(accuracy[0])
  end

  def total_games_by_coach(season)
    games_by_coach = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten)
        games_by_coach[game.head_coach] += 1
      end
    end
    games_by_coach
  end

  def winningest_coach(season)
    wins_by_coach = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten) && game.result == 'WIN'
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
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten) && game.result == ("WIN")
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
    tackles_by_team = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten)
        tackles_by_team[game.team_id] += game.tackles.to_i
      end
    end
    team_highest = tackles_by_team.max_by do |team_id, tackles|
      tackles
    end
    team_identifier(team_highest[0])
  end

  def fewest_tackles(season)
    tackles_by_team = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten)
        tackles_by_team[game.team_id] += game.tackles.to_i
      end
    end
    team_highest = tackles_by_team.min_by do |team_id, tackles|
      tackles
    end
    team_identifier(team_highest[0])
  end
end
