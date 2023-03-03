require 'csv'
require_relative './league'

class StatTracker
  attr_reader :league

  def self.from_csv(locations)
    data = {}
    locations.each do |key, csv_file_path|
      data[key] = CSV.open(csv_file_path, headers: true, header_converters: :symbol)
      data[key] = data[key].to_a.map do |row|
        row.to_h
      end
    end
    self.new(:futbol, data)
  end

  def initialize(league_name, data)
    @league = League.new(league_name, data)
  end

  def team_tackles(season_year)
    team_and_tackles = Hash.new(0)
    season = @league.seasons.find{ |season| season.year == season_year }
    season.games.each do |game|
      team_and_tackles[game.team_refs[:home_team].name] += game.team_stats[:home_team][:tackles].to_i
      team_and_tackles[game.team_refs[:away_team].name] += game.team_stats[:away_team][:tackles].to_i
    end
    team_and_tackles
  end

  def total_goals_per_game
    @league.games.map do |game|
      game.info[:home_goals] + game.info[:away_goals]
    end
  end

  def highest_total_score
    total_goals_per_game.max
  end

  def lowest_total_score
    total_goals_per_game.min
  end

  def percentage_game_result(team, result)
    count = @league.games.count do |game|
      game.team_stats[team][:result] == result
    end
    count.fdiv(@league.games.length)
  end

  def percentage_home_wins
    percentage_game_result(:home_team, "WIN").round(4)
  end

  def percentage_visitor_wins
    percentage_game_result(:home_team, "LOSS").round(4)
  end

  def percentage_ties
    percentage_game_result(:home_team, "TIE").round(4)
  end

  def count_of_games_by_season
    # # require'pry';binding.pry
    # games_by_season = Hash.new(0)
    # @league.games.each do |row|
    #   games_by_season[row[:season]] 
    # end
    # games_by_season
  end

  def average_goals_per_game

  end

  def average_goals_by_season

  end

  def count_of_teams

  end

  def best_offense

  end

  def worst_offense

  end

  def team_home_away_wins  
    team_stats = {}
    team_names = @league.teams.map do |team|
      team.name
    end
    team_names.each do |team|
      team_stats[team] = Hash.new(0)
    end
    @league.games.each do |game|
      team_stats[game.team_refs[:home_team].name][:home_goals] += game.info[:home_goals]
      team_stats[game.team_refs[:away_team].name][:away_goals] += game.info[:away_goals]
      team_stats[game.team_refs[:home_team].name][:home_games] += 1
      team_stats[game.team_refs[:away_team].name][:away_games] += 1
    end
    team_stats
  end
  
  def highest_scoring_visitor
    highest_visitor_avg_goals = team_home_away_wins.map do |team, stats|
      avg_goals = stats[:away_goals].fdiv(stats[:away_games])
      if avg_goals.nan?
        avg_goals = 0
      end
      [team, avg_goals]
    end.to_h 
    highest_visitor_avg_goals.max_by { |team, avg_goals| avg_goals }.first
  end
  
  def lowest_scoring_visitor
    lowest_visitor_avg_goals = team_home_away_wins.map do |team, stats|
      avg_goals = stats[:away_goals].fdiv(stats[:away_games])
      if avg_goals.nan?
        avg_goals = 0
      end
      [team, avg_goals]
    end.to_h
    
    lowest_visitor_avg_goals.min_by { |team, avg_goals| avg_goals }.first
  end
  
  def highest_scoring_home_team
   
  end

  def lowest_scoring_home_team

  end


  def winningest_coach

  end

  def worst_coach

  end

  def most_accurate_team

  end

  def least_accurate_team

  end

  # xdef most_tackles(season_year)
  #   team_tackles(season_year).max_by { |team, tackles| tackles }.first
  # end

  # xdef fewest_tackles(season_year)
  #   team_tackles(season_year).min_by { |team, tackles| tackles }.first
  # end
end
