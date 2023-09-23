# require 'csv'
require './spec/spec_helper'

class StatTracker 
  attr_reader :all_season_data, :game, :team_data, :game_teams, :seasons, :teams
  attr_accessor :team_data
  def initialize(locations)
    @all_season_data = AllSeasonData.new(self)
    @game = all_season_data.game_data_parser(locations[:games])
    @team_data = all_season_data.team_data_parser(locations[:teams])
    @game_teams = all_season_data.game_teams_data_parser(locations[:game_teams])
    @seasons = @all_season_data.single_seasons_creator
    @teams = []
    @team_data.each do |team|
      @teams << Team.new(self, team[:team_id])
    end
    @game_teams.each do |game|
      @teams.each do |team_object|
        team_object.tgames << game if team_object.team_id == game[:team_id]
      end
    end
    @game.each do |one_game|
      @teams.each do |team_object|
        if team_object.team_id == one_game[:away_team_id] || team_object.team_id == one_game[:home_team_id]
          team_object.games << one_game 
        end
      end
    end
    @teams.each { |teams| teams.seasons_builder }
    @games_by_season = @all_season_data.games_by_season
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    total_score = game.map do |goals|
      home_score = goals[:home_goals].to_i + away_score = goals[:away_goals].to_i
    end
    total_score.sort.last
  end 

  def lowest_total_score
    total_score = game.map do |goals|
      home_score = goals[:home_goals].to_i + away_score = goals[:away_goals].to_i
    end
    total_score.sort.first
  end

  def percentage_home_wins 
    count = 0
    game.each { |single_game| count += 1 if single_game[:home_goals].to_i > single_game[:away_goals].to_i }
    percentage = (count.to_f / game.count).round(2)
  end

  def percentage_visitor_wins
    count = 0
    game.each {|single_game| count +=1 if single_game[:away_goals] > single_game[:home_goals]}
    percentage = (count.to_f / game.length).round(2)
  end

  # def percentage_visitor_wins
  #   count = 0
  #   game.each do |single_game|
  #     if single_game[:away_goals].to_i > single_game[:home_goals].to_i
  #       count +=1
  #     end
  #   end
  #   percentage = (count.to_f / game.length).round(2)
  # end

  def percentage_ties 
    count = 0
    game.each {|single_game| count += 1 if single_game[:home_goals] == single_game[:away_goals]}
    percentage = (count.to_f / game.count).round(2)
  end

  # def percentage_ties 
  #   count = 0
  #   game.each do |single_game|
  #     if single_game[:home_goals] == single_game[:away_goals] 
  #       count += 1
  #     end 
  #   end
  #   percentage = (count.to_f / game.count).round(2)
  # end
  
  def count_of_games_by_season
    counts = Hash.new(0)
    game.each { |single_game| counts[single_game[:season]] += 1 }
    counts
  end

  def average_goals_per_game
    numerator = game_teams.sum { |game| game[:goals].to_i }.to_f
    (numerator / game_teams.count).round(2)
  end

  def average_goals_by_season
    goals = Hash.new { |hash, season| hash[season] = [] }
    game.each do |single_game|
      season = single_game[:season]
      total_score = home_score = single_game[:home_goals].to_i + single_game[:away_goals].to_i
      goals[season] << total_score
    end
    average_goals = goals.transform_values { |goal| (goal.sum.to_f / goal.length).round(2) }
    average_goals
  end

  def count_of_teams
    team_data.count
  end

  def best_offense
    team_average = @all_season_data.team_score_game_average
    best_offense_id = team_average.sort_by { |team_id, average| average }.last[0]
    team_data.find { |team| team[:team_id] == best_offense_id }[:teamname]
  end

  def worst_offense
    worst_offense = ""
    team_number = games_and_scores.sort_by { |team, data| data[:average] }.first[0]
    team_data.each do |team|
      if team[:team_id] == team_number
        worst_offense << team[:teamname]
      end
    end 
    worst_offense
  end

  def highest_scoring_visitor
    highest_scoring_visitor = ""
    highest = visitor_games_and_scores.sort_by { |team, data| data[:average] }.last[0]
  
    team_data.each do |team|
      if team[:team_id] == highest
        highest_scoring_visitor << team[:teamname]
      end
    end 
    highest_scoring_visitor
  end

  def highest_scoring_home_team
    highest_score = ""
    team_number = @all_season_data.home_team_games_scores.sort_by{ |team, data| data[:average] }.last[0]
    team_data.each do |team|
      if team[:team_id] == team_number
        highest_score << team[:teamname]
      end
    end 
    highest_score
  end

  def lowest_scoring_visitor
    lowest = away_games_and_scores.sort_by { |team, data| data[:average] }.first[0]
    team_data.find { |row| row[:team_id] == lowest }[:teamname]
  end
  
  def lowest_scoring_home_team
    lowest_scoring = ""
    lowest_avg = games_and_scores.sort_by { |team, data| data[:average] }.first[0]
    
    team_data.each do |team|
      if team[:team_id] == lowest_avg
        lowest_scoring << team[:teamname]
      end
    end 
    lowest_scoring
  end

  def winningest_coach(season)
    coach_stats = Hash.new { |hash, coach_name| hash[coach_name] = { wins: 0, games: 0 } }
    game_teams.each do |game_team|
      game_id = game_team[:game_id]
      coach = game_team[:head_coach]
      result = game_team[:result]
      if (games = game.find { |g| g[:game_id] == game_team[:game_id] && g[:season] == season })
        coach_stats[coach][:wins] += 1 if result == "WIN"
        coach_stats[coach][:games] += 1
      end
    end
    coach_win_percentages = coach_stats.transform_values do |stats|
      (stats[:wins].to_f / stats[:games]).round(2)
    end
    coach_win_percentages.key(coach_win_percentages.values.max)
  end
    
  def worst_coach(season)
    coach_stats = Hash.new { |hash, coach_name| hash[coach_name] = { wins: 0, games: 0 } }
    game_teams.each do |game_team|
      game_id = game_team[:game_id]
      coach = game_team[:head_coach]
      result = game_team[:result]
      if (games = game.find { |g| g[:game_id] == game_team[:game_id] && g[:season] == season })
        coach_stats[coach][:wins] += 1 if result == "WIN"
        coach_stats[coach][:games] += 1
      end
    end
    coach_win_percentages = coach_stats.transform_values do |stats|
      if stats[:games] > 0
        (stats[:wins].to_f / stats[:games]).round(2)
      else
        0.0
      end
    end
    coach_win_percentages.key(coach_win_percentages.values.min)
  end

  def most_accurate_team(season)
    best = season_accuracy(season).sort_by { |team, data| data[:ratio] }.last[0]
    team_data.find { |row| row[:team_id] == best }[:teamname]
  end

  def least_accurate_team(season_number)
    least_accurate = ""
    team_number = season_accuracy(season_number).sort_by { |team, data| data[:ratio] }.first[0]
    team_data.each do |team|
      if team[:team_id] == team_number
        least_accurate << team[:teamname]
      end
    end
    least_accurate
  end

  def most_tackles(season)
    most = season_tackle_hash(season).sort_by { |team, data| data[:tackles] }.last[0]
    team_data.find { |row| row[:team_id] == most }[:teamname]
  end
  
  def fewest_tackles(season)
    fewest = season_tackle_hash(season).sort_by { |team, data| data[:tackles] }.first[0]
    team_data.find { |row| row[:team_id] == fewest }[:teamname]
  end

  def games_and_scores #all seasons methods
    games_and_scores = {}

    team_data.each do |team|
      games_and_scores[team[:team_id]] = {
        average: (total_score_for_teams(team[:team_id])/
        number_of_games(team[:team_id]).to_f).round(2)
      }
    end
    games_and_scores
  end 

  def number_of_games(team) #all season methods
    number_of_games = 0
    game_teams.each do |game|
      if game[:team_id] == team
        number_of_games += 1
      end 
    end
    number_of_games
  end

  def total_score_for_teams(team) #all season methods
    total_score = 0
    game_teams.each do |game|
      if game[:team_id] == team
        total_score += game[:goals].to_i
      end 
    end
    total_score
  end

  # def home_team_games_scores #all season methods, combine with visitor games and scores
  #   games_and_scores = {}
  #   @all_season_data.home_team_games.each do |team|
  #     games_and_scores[team[:team_id]] = {
  #       average: (home_game_total_score(team[:team_id])/
  #       home_team_games_count(team[:team_id]).to_f)
  #     }
  #   end
  #   games_and_scores
  # end

  # def home_team_games #all season methods; combine with away team games; hash
  #   home_team_games = []
  #   game_teams.each do |game|
  #     home_team_games << game if game[:hoa] == "home"
  #   end
  #   home_team_games
  # end

  # def home_team_games_count(team) #all season methods
  #   number_of_games = 0
  #   @all_season_data.home_team_games.each do |game|
  #     number_of_games += 1 if game[:team_id] == team
  #   end
  #   number_of_games
  # end

  # def home_game_total_score(team) #all season methods, combine with away_game_total_score 
  #   #total_score = {}
  #   #away_team_games.each do |game| xyz
  #   total_score = 0
  #   @all_season_data.home_team_games.each do |game|
  #     total_score += game[:goals].to_i if game[:team_id] == team
  #   end
  #   total_score
  # end

  def visitor_games_and_scores # all season methods
    games_and_scores = {}
    team_data.each do |team|
      games_and_scores[team[:team_id]] = {
        average: (total_score_for_visiting_teams(team[:team_id])/
        number_of_visitor_games(team[:team_id]).to_f)
      }
    end
    games_and_scores
  end 

  
  # @all_season_data.number_of_visitor_games(team)
  # number_of_visitor_games
  
  def total_score_for_visiting_teams(team)
    total_score = 0
    game_teams.each do |game|
      if game[:team_id] == team && game[:hoa] == "away"
        total_score += game[:goals].to_i
      end 
    end
    total_score
  end
  
  def away_games_and_scores #all seasons ; combined with  home games and scores
    away_games_hash = {}
    team_data.each do |team|
      away_games_hash[team[:team_id]] = {
        average: (total_score_for_away_teams(team[:team_id])/
        number_of_away_games(team[:team_id]).to_f)
      }
    end
    away_games_hash
  end 

  def number_of_visitor_games(team) # all season methods ; combine with number_of_away_games
    number_of_games = 0
    game_teams.each do |game|
      if game[:team_id] == team && game[:hoa] == "away"
        number_of_games += 1
      end 
    end
    number_of_games
  end

  def number_of_away_games(team) #all season
    away_team_data = game_teams.select { |row|  row[:hoa] == 'away' }
    game_teams.count { |game| game[:team_id] == team }
  end

  def total_score_for_away_teams(team) #all season
    away_team_data = game_teams.select { |row| row[:hoa] == 'away' }
    total_score = 0
    away_team_data.each do |game|
      if game[:team_id] == team
        total_score += game[:goals].to_i
      end 
    end
    total_score
  end
  
  def season_tackle_hash(season) #single seasons
    tackles_by_team = {}
    team_data.each do |team|
      tackles_by_team[team[:team_id]] = {
        tackles: season_tackles(team[:team_id], season)
      }
    end
    tackles_by_team
  end
  
  def season_tackles(team, season) #single seasons
    total_tackles = 0
    season_game_teams(season).each do |game|
      total_tackles += game[:tackles].to_i if game[:team_id] == team
    end
    total_tackles
  end

  def season_accuracy(season_number) #single season 
    team_info = {}
    season(season_number).each do  |team|
      team_info[team[:team_id]] = { 
        ratio: ((season_total_goals(team[:team_id], season_number)/season_total_shots(team[:team_id], season_number).to_f)).round(5),
      }
    end
    team_info
  end

  def season_total_shots(team, season_number) #single season
    total_shots = 0
    season(season_number).each do |game|
      if game[:team_id] == team
        total_shots += game[:shots].to_i
      end 
    end
    total_shots
  end

  def season_total_goals(team, season_number) #single season
    total_goals = 0
    season(season_number).each do |game|
      if game[:team_id] == team
        total_goals += game[:goals].to_i
      end 
    end
    total_goals
  end

  def games_by_season #single seasons
    games_by_season_hash = Hash.new([])
    game.each do |one_game|
      games_by_season_hash[one_game[:season]] += [one_game[:game_id]]
    end
    games_by_season_hash
  end

  def season_game_teams(season) #single seasons
    season_array = games_by_season[season]
    game_teams.find_all { |game| season_array.include?(game[:game_id]) }
  end
  

  




  def season(season_number) #single season
    season_games = []
    season_games_both_teams = []
    game.each { |game|  season_games << game if game[:season] == season_number }
    game_teams.each do |game|
      season_games.each do |season_game|
        if game[:game_id].include?(season_game[:game_id])
          season_games_both_teams << game
        end
      end
    end
    season_games_both_teams
  end

end

