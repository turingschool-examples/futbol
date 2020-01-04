require_relative 'game_team'
require_relative 'game'
require_relative 'team'

class StatTracker
  attr_reader :game_path, :team_path, :game_teams_path, :game_teams, :games, :teams

  def self.from_csv(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_teams_path = locations[:game_teams]
    StatTracker.new(game_path, team_path, game_teams_path)
  end

  def initialize(game_path, team_path, game_teams_path)
    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path
    @game_teams = GameTeam.from_csv(@game_teams_path)
    @games = Game.from_csv(@game_path)
    @teams = Team.from_csv(@team_path)
  end

  def highest_total_score
    Game.highest_total_score
  end

  def lowest_total_score
    Game.lowest_total_score
  end

  def biggest_blowout
    Game.biggest_blowout
  end

  def average_goals_per_game
    Game.average_goals_per_game
  end

  def percentage_home_wins
    GameTeam.percentage_home_wins
  end

  def percentage_visitor_wins
    GameTeam.percentage_visitor_wins
  end

  def percentage_ties
    Game.percentage_ties
  end

  def count_of_games_by_season
    Game.count_of_games_by_season
  end

  def average_goals_by_season
    Game.average_goals_by_season
  end

  def count_of_teams
    Team.count_of_teams
  end

  def worst_fans
    unique_teams = @game_teams.reduce({}) do |acc, game_team|
      acc[game_team.team_id] = {away: 0, home: 0}
      acc
    end

    @game_teams.each do |game_team|
      if game_team.hoa == "away" && game_team.result == "WIN"
        unique_teams[game_team.team_id][:away] += 1
      elsif game_team.hoa == "home" && game_team.result == "WIN"
        unique_teams[game_team.team_id][:home] += 1
      end
    end

    worst_fans_are = unique_teams.find_all do |key, value|
      value[:away] > value[:home]
    end.to_h

    worst_teams = worst_fans_are.to_h.keys

    final = worst_teams.map do |team2|
      @teams.find do |team1|
        team2 == team1.team_id
      end
    end

    finnalist = final.map do |team|
      team.teamname
    end
  end

  def best_fans
    unique_teams = @game_teams.reduce({}) do |acc, game_team|
      acc[game_team.team_id] = {away: 0, home: 0}
      acc
    end

    @game_teams.each do |game_team|
      unique_teams[game_team.team_id][:away] += 1 if game_team.hoa == "away" && game_team.result == "WIN"
    end

    best_fans = unique_teams.max_by do |team|
      team[1][:home] - team[1][:away]
    end

    @teams.find do |team|
      team.team_id == best_fans[0]
    end.teamname
  end

  def best_offense
    team_goals = @game_teams.reduce({}) do |acc, game_team|
      acc[game_team.team_id] = 0
      acc
    end
     @game_teams.each do |game_team|
      team_goals[game_team.team_id] += game_team.goals
    end
    team_goals

    total_games = @game_teams.reduce({}) do |acc, game_team|
      acc[game_team.team_id] = 0
      acc
    end
    @game_teams.each do |game_team|
      total_games[game_team.team_id] += 1
    end
    total_games

    average = team_goals.merge(total_games) do |key, team_goals, total_games|
      team_goals / total_games.to_f
    end
    best_o = average.max_by do |k, v|
      v
    end
    final = @teams.find do |team|
      team.team_id == best_o[0]
    end
    final.teamname
  end

  def worst_offense
    team_goals = @game_teams.reduce({}) do |acc, game_team|
      acc[game_team.team_id] = 0
      acc
    end
     @game_teams.each do |game_team|
      team_goals[game_team.team_id] += game_team.goals
    end
    team_goals

    total_games = @game_teams.reduce({}) do |acc, game_team|
      acc[game_team.team_id] = 0
      acc
    end
    @game_teams.each do |game_team|
      total_games[game_team.team_id] += 1
    end
    total_games

    average = team_goals.merge(total_games) do |key, team_goals, total_games|
      team_goals / total_games.to_f
    end

    worst_o = average.min_by do |k, v|
      v
    end

    final = @teams.find do |team|
      team.team_id == worst_o[0]
    end
    final.teamname
  end

  def highest_scoring_home_team
    team_goals = @game_teams.reduce({}) do |acc, game_team|
      acc[game_team.team_id] = {:total_games => 0, :total_goals => 0}
      acc
    end

    @game_teams.each do |game_team|
      if game_team.hoa == "home"
        team_goals[game_team.team_id][:total_games] += 1
        team_goals[game_team.team_id][:total_goals] += game_team.goals
      end
    end

    highest_team_id = team_goals.max_by do |k , v|
      v[:total_goals] / v[:total_games].to_f
    end[0]

    final = @teams.find do |team|
      team.team_id == highest_team_id
    end
    final.teamname
  end

  def lowest_scoring_home_team
    team_goals = @game_teams.reduce({}) do |acc, game_team|
      acc[game_team.team_id] = {:total_games => 0, :total_goals => 0}
      acc
    end

    @game_teams.each do |game_team|
      if game_team.hoa == "home"
        team_goals[game_team.team_id][:total_games] += 1
        team_goals[game_team.team_id][:total_goals] += game_team.goals
      end
    end

    lowest_team_id = team_goals.min_by do |k , v|
      v[:total_goals] / v[:total_games].to_f
    end[0]

    final = @teams.find do |team|
      team.team_id == lowest_team_id
    end
    final.teamname
  end

  def winningest_team
    total_games_per_team = @game_teams.reduce(Hash.new(0)) do |acc, game_team|
      acc[game_team.team_id] +=1
      acc
    end

    total_team_wins = @game_teams.reduce(Hash.new(0)) do |acc, game_team|
      acc[game_team.team_id] += 1 if game_team.result == "WIN"
      acc
    end

    team_win_percentage = total_team_wins.merge(total_games_per_team) do |game_team, wins, games|
      (wins.to_f/games).round(2)
    end

    winningest_team_id = team_win_percentage.max_by do |game_team, percentage|
      percentage
    end.first

    best_team = @teams.find do |team|
      team.team_id == winningest_team_id
    end

    best_team.teamname
  end

  def highest_scoring_visitor
    team_goals = @game_teams.reduce({}) do |acc, game_team|
      acc[game_team.team_id] = {:total_games => 0, :total_goals => 0}
      acc
    end
    @game_teams.each do |game_team|
      if game_team.hoa == "away"
        team_goals[game_team.team_id][:total_games] += 1
        team_goals[game_team.team_id][:total_goals] += game_team.goals
      end
    end
      highest_team_id = team_goals.max_by do |k , v|
      v[:total_goals] / v[:total_games].to_f
    end[0]

      final = @teams.find do |team|
      team.team_id == highest_team_id
    end
    final.teamname
  end

  def lowest_scoring_visitor
    all_teams = @game_teams.reduce({}) do |acc, game_team|
        acc[game_team.team_id] = {total_games: 0, total_goals: 0}
        acc
    end

    @game_teams.each do |game_team|
      if game_team.hoa == "away"
        all_teams[game_team.team_id][:total_games] += 1
        all_teams[game_team.team_id][:total_goals] += game_team.goals
      end
    end

    worst_team = all_teams.min_by do |key, value|
      value[:total_goals] / value[:total_games].to_f
    end[0]

    final = @teams.find do |team|
      team.team_id == worst_team
    end
    final.teamname
  end

  def worst_defense
    teams_counter = @games.reduce({}) do |acc, game|
      acc[game.home_team_id] = {games: 0, goals_allowed: 0}
      acc[game.away_team_id] = {games: 0, goals_allowed: 0}
      acc
    end

    @games.each do |game|
      teams_counter[game.home_team_id][:games] += 1
      teams_counter[game.away_team_id][:games] += 1
      teams_counter[game.away_team_id][:goals_allowed] += game.home_goals
      teams_counter[game.home_team_id][:goals_allowed] += game.away_goals
    end

    final = teams_counter.max_by do |id, stats|
      stats[:goals_allowed].to_f / stats[:games]
    end[0]

    @teams.find do |team|
      team.team_id == final
    end.teamname
  end
end
