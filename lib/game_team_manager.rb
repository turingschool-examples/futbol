require 'csv'

class GameTeamManager
  attr_reader :game_teams,
              :tracker
  def initialize(path, tracker)
    @game_teams = []
    create_underscore_game_teams(path)
    @tracker = tracker
  end

  def create_underscore_game_teams(path)
    game_teams_data = CSV.read(path, headers: true)
    @game_teams = game_teams_data.map do |data|
      GameTeam.new(data, self)
    end
  end

  def average_win_percentage(team_id)
    team_game_count = Hash.new(0)
    team_wins = Hash.new(0)
    @game_teams.each do |game|
      if game.team_id == team_id
        team_game_count[game.team_id] += 1
        if game.result == "WIN"
          team_wins[game.team_id] += 1
        end
      end
    end
    (team_wins[team_id].to_f / team_game_count[team_id]).round(2)
  end

  def best_offense
    team_ids = Hash.new(0)
    team_game_count = Hash.new(0)
    @game_teams.each do |game_team|
      team_ids[game_team.team_id] += game_team.goals
      team_game_count[game_team.team_id] += 1
    end
    highest_scoring_team = team_ids.max_by do |team, score|
      score.to_f / team_game_count[team]
    end[0]
    @tracker.get_team_name(highest_scoring_team)
  end

  def worst_offense
    team_ids = Hash.new(0)
    team_game_count = Hash.new(0)
    @game_teams.each do |game_team|
      team_ids[game_team.team_id] += game_team.goals
      team_game_count[game_team.team_id] += 1
    end
    lowest_scoring_team = team_ids.min_by do |team, score|
      score.to_f / team_game_count[team]
    end[0]
    @tracker.get_team_name(lowest_scoring_team)
  end

  def most_accurate_team(season)
    game_ids = @tracker.get_season_game_ids(season)
    total_shots_by_team = Hash.new(0.0)
    total_goals_by_team = Hash.new(0.0)
    @game_teams.each do |game|
      if game_ids.include?(game.game_id)
        total_shots_by_team[game.team_id] += game.shots.to_f
        total_goals_by_team[game.team_id] += game.goals.to_f
      end
    end
    most_accurate_team = total_goals_by_team.max_by do |team, goal|
      goal / total_shots_by_team[team]
    end[0]
    @tracker.get_team_name(most_accurate_team)
  end

  def least_accurate_team(season)
    game_ids = @tracker.get_season_game_ids(season)
    total_shots_by_team = Hash.new(0.0)
    total_goals_by_team = Hash.new(0.0)
    @game_teams.each do |game|
      if game_ids.include?(game.game_id)
        total_shots_by_team[game.team_id] += game.shots.to_f
        total_goals_by_team[game.team_id] += game.goals.to_f
      end
    end
    least_accurate_team = total_goals_by_team.min_by do |team, goal|
      goal / total_shots_by_team[team]
    end[0]
    @tracker.get_team_name(least_accurate_team)
  end
end
