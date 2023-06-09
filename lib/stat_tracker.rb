require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_by_team'

class StatTracker

  attr_reader :games,
              :teams,
              :game_teams


  def initialize(files)
    @games = (CSV.open files[:games], headers: true, header_converters: :symbol).map do |row|
      Game.new(row)
    end
    @teams = (CSV.open files[:teams], headers: true, header_converters: :symbol).map do |row|
      Team.new(row)
    end
    @game_teams = (CSV.open files[:game_teams], headers: true, header_converters: :symbol).map do |row|
      GameTeam.new(row)
    end
  end

  def self.from_csv(files)
    StatTracker.new(files)
  end

#---------Game Statics Methods-----------
  def percentage_ties
    tie_count = @games.count { |game| game.away_goals.to_i == game.home_goals.to_i }
    percentage = (tie_count.to_f / @games.count.to_f).round(4) * 100
    percentage
  end

  def count_of_games_by_season
  season_games = @games.each_with_object(Hash.new(0)) {|game, hash| hash[game.season] += 1}
  season_games
  end

  def highest_total_score
    highest_score = 0
    @games.each do |game|
      total_score = game.home_goals.to_i + game.away_goals.to_i
      highest_score = total_score if total_score > highest_score
    end
    highest_score
  end

  def lowest_total_score
    lowest_score = nil
    @games.each do |game|
      total_score = game.home_goals.to_i + game.away_goals.to_i
      lowest_score = total_score if lowest_score.nil? || total_score < lowest_score
    end
    lowest_score
  end

  def percentage_visitor_wins
    away_wins = @game_teams.find_all do |game|
      (game.hoa == "away") && (game.result == "WIN")
    end
    ((away_wins.count.to_f / @game_teams.count.to_f) * 100).ceil(2)
  end

  def average_goals_per_game
    total_goals = 0
    @games.each do |game|
      total_goals += (game.away_goals.to_i + game.home_goals.to_i)
    end
    (total_goals.to_f / @games.count.to_f).ceil(2)
  end

  def percentage_home_wins
    home_wins = @games.find_all do |game|
      game.home_goals > game.away_goals
    end
    result = ((home_wins.count.to_f / @games.count) * 100) / 100
    result.round(2)
  end

  def average_goals_by_season
    goals_by_season = {}
    @games.each do |game|
      away = game.away_goals.to_i
      home = game.home_goals.to_i

      if goals_by_season.key?(game.season)
        goals_by_season[game.season] += (away + home)
      else
        goals_by_season[game.season] = away + home
      end
    end

    average_goals_by_s = {}
    goals_by_season.each do |key, value|
      average_goals_by_s[key] = (value.to_f / count_of_games_by_season[key]).round(2)
    end

    average_goals_by_s
  end
#-------------- League Statics Methods --------
  def count_of_teams
    @teams.count
  end

  def best_offense
    average_goals_by_team
    highest_scoring_team = average_goals_by_team.max_by {|team, avg_goals| avg_goals}
    @teams.each {|team| return highest_scoring_team_name = team.team_name if team.team_id == highest_scoring_team[0]}
    highest_scoring_team_name
  end

  def worst_offense
    average_goals_by_team
    lowest_scoring_team = average_goals_by_team.min_by {|team, avg_goals| avg_goals}
    @teams.each {|team| return lowest_scoring_team_name = team.team_name if team.team_id == lowest_scoring_team[0]}
    lowest_scoring_team_name
  end

  def average_goals_by_team
    goals_scored = @game_teams.each_with_object(Hash.new(0)) {|game, team_hash| team_hash[game.team_id] += game.goals.to_i}
    games_played = @game_teams.each_with_object(Hash.new(0)) {|game, team_hash| team_hash[game.team_id] += 1}
    average_goals_per_game = Hash.new(0)
    goals_scored.each do |key1, value1|
      games_played.each do |key2, value2|
          average_goals_per_game[key1] = value1.to_f / value2.to_f if key1 == key2
      end
    end
    average_goals_per_game
  end

  def lowest_scoring_visitor
    goals_scored_as_visitor = @game_teams.each_with_object(Hash.new(0)) do |game, team_hash|
        team_hash[game.team_id] += game.goals.to_i if game.hoa == "away"
    end
    games_played_as_visitor = @game_teams.each_with_object(Hash.new(0)) do |game, team_hash|
        team_hash[game.team_id] += 1 if game.hoa == "away"
    end
    average_goals_per_game = Hash.new(0)
    goals_scored_as_visitor.each do |key1, value1|
      games_played_as_visitor.each do |key2, value2|
          average_goals_per_game[key1] = value1.to_f / value2.to_f if key1 == key2
      end
    end
    lowest_scoring_team = average_goals_per_game.min_by {|team, avg_goals| avg_goals}
    @teams.each {|team| return lowest_scoring_team_name = team.team_name if team.team_id == lowest_scoring_team[0]}
    lowest_scoring_team_name
  end

  def lowest_scoring_home_team
    goals_scored_at_home = @game_teams.each_with_object(Hash.new(0)) do |game, team_hash|
        team_hash[game.team_id] += game.goals.to_i if game.hoa == "home"
    end
    games_played_at_home = @game_teams.each_with_object(Hash.new(0)) do |game, team_hash|
        team_hash[game.team_id] += 1 if game.hoa == "home"
    end
    average_goals_per_game = Hash.new(0)
    goals_scored_at_home.each do |key1, value1|
      games_played_at_home.each do |key2, value2|
          average_goals_per_game[key1] = value1.to_f / value2.to_f if key1 == key2
      end
    end
    lowest_scoring_team = average_goals_per_game.min_by {|team, avg_goals| avg_goals}
    @teams.each {|team| return lowest_scoring_team_name = team.team_name if team.team_id == lowest_scoring_team[0]}
    lowest_scoring_team_name
  end

  def highest_scoring_visitor
    highest_average_score = 0
    highest_scoring_team = ""

    @game_teams.each do |game|
      next unless game.hoa == "away"

      team = @teams.find { |t| t.team_id == game.team_id }
      next unless team

      total_games = @game_teams.count { |g| g.team_id == team.team_id }
      average_score = (game.goals.to_f / total_games)

      if average_score > highest_average_score
        highest_average_score = average_score
        highest_scoring_team = team.team_name
      end
    end

    highest_scoring_team
  end

  def highest_scoring_home_team
    highest_average_score = 0
    highest_scoring_team = ""

    @game_teams.each do |game|
      next unless game.hoa == "home"

      team = @teams.find { |t| t.team_id == game.team_id }
      next unless team

      total_games = @game_teams.count { |g| g.team_id == team.team_id }
      average_score = (game.goals.to_f / total_games)

      if average_score > highest_average_score
        highest_average_score = average_score
        highest_scoring_team = team.team_name
      end
    end

    highest_scoring_team
  end

#-------------- Season Statics Methods --------
  def most_tackles
    total_tackle_by_team = {}
    @game_teams.each do |game|
      if total_tackle_by_team.key?(game.team_id)
        total_tackle_by_team[game.team_id] += game.tackles.to_i
      else
        total_tackle_by_team[game.team_id] = game.tackles.to_i
      end
    end

    team_with_most_tackles = total_tackle_by_team.max_by { |key, value| value }&.first
    result = @teams.find { |team| team.team_id == team_with_most_tackles }
    result.team_name
  end

  def fewest_tackles
    total_tackle_by_team = {}
    @game_teams.each do |game|
      if total_tackle_by_team.key?(game.team_id)
        total_tackle_by_team[game.team_id] += game.tackles.to_i
      else
        total_tackle_by_team[game.team_id] = game.tackles.to_i
      end
    end

    team_with_fewest_tackles = total_tackle_by_team.min_by { |key, value| value }&.first
    result = @teams.find { |team| team.team_id == team_with_fewest_tackles }
    result.team_name
  end

  def most_accurate_team
    total_shots_by_team = {}
    @game_teams.each do |game|
      if total_shots_by_team.key?(game.team_id)
        total_shots_by_team[game.team_id] += game.tackles.to_i
      else
        total_shots_by_team[game.team_id] = game.tackles.to_i
      end
    end
    most_accurate = {}

    total_shots_by_team.each do |key, value|
      most_accurate[key] = value.to_f / total_goals_by_teams[key]
    end

    result = most_accurate.max_by { |key, value| value }&.first
    final_result = @teams.find { |team| team.team_id == result }
    final_result.team_name
  end

  def least_accurate_team
    total_shots_by_team = {}
    @game_teams.each do |game|
      if total_shots_by_team.key?(game.team_id)
        total_shots_by_team[game.team_id] += game.tackles.to_i
      else
        total_shots_by_team[game.team_id] = game.tackles.to_i
      end
    end
    least_accurate = {}

    total_shots_by_team.each do |key, value|
      least_accurate[key] = value.to_f / total_goals_by_teams[key]
    end

    result = least_accurate.min_by { |key, value| value }&.first
    final_result = @teams.find { |team| team.team_id == result }
    final_result.team_name
  end

  def total_goals_by_teams
    total_goals = {}
    @game_teams.each do |game|
      if total_goals.key?(game.team_id)
        total_goals[game.team_id] += game.goals.to_i
      else
        total_goals[game.team_id] = game.goals.to_i
      end
    end
    total_goals
  end

  def winningest_coach(season_id)
    coachs = []
    @game_teams.find_all do |game|
      coachs << game.head_coach
    end
    games_by_season = []
    @games.each do |game|
      games_by_season << game.game_id if game.season == season_id
    end
    coachs.uniq!.max_by do |coach|
      coach_wins = @game_teams.find_all {|game|  (game.head_coach == coach && game.result == "WIN") && (games_by_season.include?(game.game_id))}
      coach_games = game_teams.find_all {|game| game.head_coach == coach}
      ((coach_wins.count.to_f / coach_games.count.to_f) * 100)
    end
  end

  def worst_coach(season_id)
    coachs = []
    @game_teams.find_all do |game|
      coachs << game.head_coach
    end
    games_by_season = []
    @games.each do |game|
      games_by_season << game.game_id if game.season == season_id
    end
    coachs.uniq!.max_by do |coach|
      coach_wins = @game_teams.find_all {|game|  game.head_coach == coach && game.result == "LOSS" && (games_by_season.include?(game.game_id))}
      coach_games = @game_teams.find_all {|game| game.head_coach == coach}
      ((coach_wins.count.to_f / coach_games.count.to_f) * 100)
    end
  end
end

