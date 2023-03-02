require 'csv'

class SeasonStats
  def initialize
    @teams = CSV.open('./data/teams.csv', headers: true, header_converters: :symbol).map { |row| Team.new(row) }
    @games = CSV.open('./data/games.csv', headers: true, header_converters: :symbol).map { |row| Game.new(row) }
    @game_teams = CSV.open('./data/game_teams.csv', headers: true, header_converters: :symbol).map { |row| GameTeams.new(row) }
  end

  def most_accurate_team(season)
    team = @teams.select do |team|
     team.team_id == team_id_best_shot_perc_by_season(season)
    end
    team.first.team_name
  end

  def least_accurate_team(season)
    team = @teams.select do |team|
     team.team_id == team_id_worst_shot_perc_by_season(season)
    end
    team.first.team_name
  end

  def all_goals_by_team_by_season(season)
    team_goals_season = Hash.new(0)
    @game_teams.each do |game|
      if season == game.season_id
      team_goals_season[game.team_id] += game.goals.to_i
      end
    end
    team_goals_season
  end

  def all_shots_by_team_by_season(season)
    team_shots_season = Hash.new(0)
    @game_teams.each do |game|
      if season == game.season_id
      team_shots_season[game.team_id] += game.shots.to_i
      end
    end
    team_shots_season
  end

  def teams_shot_percentage_by_season(season)
    all_goals_by_team_by_season(season).merge(all_shots_by_team_by_season(season)) do |team_id, goals, shots|
      goals.fdiv(shots)
    end
  end

  def team_id_best_shot_perc_by_season(season)
    team_id = teams_shot_percentage_by_season(season).max_by {|_, percentage| percentage}
    team_id.first
  end

  def team_id_worst_shot_perc_by_season(season)
    team_id = teams_shot_percentage_by_season(season).min_by {|_, percentage| percentage}
    team_id.first
  end  
end