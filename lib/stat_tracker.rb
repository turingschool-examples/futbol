

class StatTracker
  attr_reader :games, :teams, :game_teams

  def self.from_csv(file_paths)
    game_path = file_paths[:games]
    team_path = file_paths[:teams]
    game_teams_path = file_paths[:game_teams]

    StatTracker.new(game_path, team_path, game_teams_path)
  end

  def initialize(game_path, team_path, game_teams_path)
    @games = Games.new(game_path)
    @teams = Teams.new(team_path)
    @game_teams = GameTeams.new(game_teams_path)
  end

#dont want a path as an instance varaible. ONly use path once
#every time we call teams its initializing a new team every time
  # def games
  #   Games.new(@game_path)
  # end
  #
  # def teams
  #   Teams.new(@team_path)
  # end
  #
  # def game_teams
  #   GameTeams.new(@game_teams_path)
  # end



  def count_of_teams
    @teams.all.size
  end

  # Name of the team with the highest average
  # score per game across all seasons when they are away.
  # {team_name: num_goals, team_name2: num_goals...}

  def highest_scoring_visitor
    away_team_goals = @games.all.reduce({}) do |teams, game|
      teams[game.away_team_id] = game.away_goals
      teams
    end
    x = away_team_goals.max_by{|team_id, away_goals| away_goals}
    # get key value pair where the value is the highest
    # find team that has the key
    
    require "pry"; binding.pry
  end

  def worst_offense
    average_goals_per_team = @teams.all.map do |team|
      total_goals = total_goals_per_team(team.team_id)
      total_games = total_games_per_team(team.team_id)
      if total_games != 0
        {
          team.team_name => total_goals / total_games
        }
      else
        {
          team.team_name => 0
        }
      end
    end
    average_goals_per_team.min do |statistic|
      statistic.values.first
    end.keys.first

  end

  def best_offense
    average_goals_per_team = @teams.all.map do |team|
      total_goals = total_goals_per_team(team.team_id)
      total_games = total_games_per_team(team.team_id)
      if total_games != 0
        {
          team.team_name => total_goals / total_games
        }
      else
        {
          team.team_name => 0
        }
      end
    end
    average_goals_per_team.max do |statistic|
      statistic.values.first
    end.keys.first
  end

  def total_goals_per_team(team_id)
    @games.all.sum do |game|
      is_home_team = game.home_team_id == team_id
      is_away_team = game.away_team_id == team_id
      if is_home_team
        game.home_goals
      elsif is_away_team
        game.away_goals
      else
        0
      end
    end
  end

  def total_games_per_team(team_id)
    @games.all.sum do |game|
      is_home_team = game.home_team_id == team_id
      is_away_team = game.away_team_id == team_id
      if is_home_team || is_away_team
        1
      else
        0
      end
    end
  end
end
