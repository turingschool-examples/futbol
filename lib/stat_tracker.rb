require_relative '../spec/spec_helper'

class StatTracker 
  attr_reader :data, 
              :teams, 
              :games, 
              :game_teams,
              :seasons_by_id

  def initialize(data)
    @data = data
    @teams = processed_teams_data(@data)
    @games = processed_games_data(@data)
    @game_teams = processed_game_teams_data(@data)
    @seasons_by_id = processed_seasons_data
  end
  
  def self.from_csv(locations)
    new_locations = {}
    locations.each do |key,value|
      new_locations[key] = CSV.open value, headers: true, header_converters: :symbol
    end
    new(new_locations)
  end
  
  def processed_teams_data(locations)
    all_teams = []
    teams = @data[:teams]
    teams.each do |row|
      all_teams << Team.new(row)
    end
    @teams = all_teams
  end
  
  def processed_games_data(locations)
    all_games = []
    games = @data[:games]
    games.each do |row|
      all_games << Game.new(row)
    end
    @games = all_games
  end

  def processed_game_teams_data(locations)
    all_game_teams = []
    game_teams = @data[:game_teams]
    game_teams.each do |row|
      all_game_teams << GameTeam.new(row)
    end
    @game_teams = all_game_teams
  end

  def processed_seasons_data
    all_seasons = Hash.new
    @games.map{|game| game.season}.uniq.each do |season_id|
      new_season = Season.new(season_id, @games, @game_teams)
      all_seasons[season_id] = new_season.season_data
    end
    all_seasons
  end

  def percentage_home_wins
    home_teams = @game_teams.select do |team|
      team.hoa == "home"
    end
    winning_teams = home_teams.select do |team|
      team.result == "WIN"
    end
    percentage_wins = winning_teams.count / home_teams.count.to_f
    percentage_wins.round(2)
  end

  def percentage_visitor_wins
    visitor_teams = @game_teams.select do |team|
      team.hoa == "away"
    end
    winning_teams = visitor_teams.select do |team|
      team.result == "WIN"
    end
    percentage_wins = winning_teams.count / visitor_teams.count.to_f
    percentage_wins.round(2)
  end
  
  def percentage_ties
    games_tied = @game_teams.select do |game|
      game.result == "TIE"
    end
    games_tied_float = games_tied.count / @game_teams.count.to_f
    games_tied_float.round(2)
  end

  def highest_total_score
    highest_goal = @games.max_by do |game|
      game.away_goals + game.home_goals 
    end
    highest_goal.away_goals + highest_goal.home_goals
  end

  def lowest_total_score
    lowest_goals = @games.min_by do |game|
      game.away_goals + game.home_goals 
    end
    lowest_goals.away_goals + lowest_goals.home_goals
  end

  def average_goals_per_game
    total_goals = 0
    total_games = @games.count
      @games.each do |game|
      total_goals += game.away_goals + game.home_goals
    end
    (total_goals.to_f / total_games).round(2)
  end

  def count_of_teams
    @teams.count
  end

  def winningest_coach(season_id)
    season_games = @seasons_by_id[season_id][:game_teams]
    games_won_coach = Hash.new(0)
    games_played_coach = Hash.new(0)
    coach_win_percentage = Hash.new
    season_games.each do |game|
      games_played_coach[game.head_coach] += 1
      if game.result == "WIN"
      games_won_coach[game.head_coach] += 1
      end
    end
    games_played_coach.each do |coach, games|
      games_won_coach.each do |won_coach, won_games|
      if coach == won_coach
        coach_win_percentage[coach] = (won_games / games.to_f)
        end
      end
    end
    #hash.max_by{ |k,v| v }[0] gives the key
    coach_win_percentage.max_by {|coach, percentage| percentage}[0]
  end
end

