require 'csv'

class GameData 
  attr_reader :home_wins,
              :away_wins,
              :ties,
              :total_games,
              :total_goals,
              :home_scores,
              :away_scores

  attr_accessor :games

  def initialize
    @games = []
    @home_wins = 0
    @away_wins = 0
    @ties = 0
    @total_games = 0
    @total_goals = 0
    @home_scores = Hash.new(0)
    @away_scores = Hash.new(0)
    @teams = []
    @lowest_scoring_away_team = nil
    @lowest_scoring_home_team = nil
  end

  def add_games 
    games = CSV.open './data/games.csv', headers: true, header_converters: :symbol
    games.each do |row|
      id = row[:game_id]
      season = row[:season]
      type = row[:type]
      date_time = row[:date_time]
      away = row[:away_team_id]
      home = row[:home_team_id]
      away_goals = row[:away_goals]
      home_goals = row[:home_goals]
      venue = row[:venue]
      venue_link = row[:venue_link]
      @games << Game.new(id, season, type, date_time, away, home, away_goals, home_goals, venue, venue_link)
    end
  end

  def wins_losses
    @games.each do |game|
      if game.home_goals > game.away_goals
        @home_wins += 1 
        @total_games += 1
      elsif game.home_goals < game.away_goals
        @away_wins += 1
        @total_games += 1
      elsif game.home_goals == game.away_goals
        @ties += 1 
        @total_games += 1
      end
    end
  end

  def percentage_home_wins
    (@home_wins.to_f / @total_games).round(2)
  end
 
  def percentage_visitor_wins
    (@away_wins.to_f / @total_games).round(2)
  end

  def percentage_ties
    (@ties.to_f / @total_games).round(2)
  end

  def total_scores
    total_scores = @games.map do |game|
      (game.away_goals).to_i + (game.home_goals).to_i
    end.sort
  end

  def highest_total_score
    total_scores.last
  end
  
  def lowest_total_score
    total_scores.first
  end

  def count_of_games_by_season
    hash = Hash.new(0)
    @games.each do |game|
      hash[game.season] += 1
    end
    hash
  end

  def average_goals_per_game
    @games.each do |game|
      @total_games += 1
      @total_goals += (game.away_goals.to_f + game.home_goals.to_f)
    end
    average = @total_goals / @total_games
    average.round(2)
  end

  def average_goals_by_season
    average_goals_by_season = Hash.new(0)
    goals_p_season = goals_per_season()
    games_p_season = games_per_season()
    @games.each {|game| average_goals_by_season[game.season] = 0}
    average_goals_by_season.each do |key, value|
      average_goals_by_season[key] = goals_per_season[key].to_f / games_per_season[key].to_f
      average_goals_by_season[key] = average_goals_by_season[key].round(2)
    end
    average_goals_by_season
  end

  #Helper method for average_goals_by_season
  def goals_per_season
    goals_per_season = Hash.new(0)
    @games.each do |game|
      goals_per_season[game.season] += (game.home_goals.to_i + game.away_goals.to_i)
    end
    goals_per_season
  end

  #Helper method for average_goals_by_season  
  def games_per_season
    games_per_season = Hash.new(0)
    @games.each do |game|
      games_per_season[game.season] += 1
    end
    games_per_season
  end


  def highest_home_avg_score
    scores = Hash.new(0)
    @games.each do |game|
      scores[(game.home)] += (game.home_goals).to_i
      scores.max_by{|k,v| v}[0]
    end
  end
  
  def highest_away_avg_score
    scores = Hash.new(0)
    @games.each do |game|
      scores[(game.away)] += (game.away_goals).to_i
      scores.max_by{|k,v| v}[0]

  def team_goals
    @games.each do |game|
      @away_scores[game.away] += game.away_goals.to_i
      @home_scores[game.home] += game.home_goals.to_i
    end
  end

  def lowest_scoring_away
    lowest_scoring_team = @away_scores.min_by{|k, v| v}
    @teams.each do |team|
      if team.team_id == lowest_scoring_team[0]
        @lowest_scoring_away_team = team.teamname
      end
    end
    @lowest_scoring_away_team
  end

  def lowest_scoring_home
    lowest_scoring_team = @home_scores.min_by{|k, v| v}
    @teams.each do |team|
      if team.team_id == lowest_scoring_team[0]
        @lowest_scoring_home_team = team.teamname
      end
    end
    @lowest_scoring_home_team
  end

  def add_teams
    teams = CSV.open './data/teams.csv', headers: true, header_converters: :symbol
    teams.each do |row|
      team_id = row[:team_id]
      franchiseid = row[:franchiseid]
      teamname = row[:teamname]
      abbreviation = row[:abbreviation]
      stadium = row[:stadium]
      link = row[:link]
      @teams << Team.new(team_id, franchiseid, teamname, abbreviation, stadium, link)
    end
  end
end