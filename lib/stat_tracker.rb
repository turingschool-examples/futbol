require 'csv'
require './lib/season_helper_module'
require './lib/game_stat_module'
require './lib/league_helper_module'

class StatTracker
  include Seasonable
  include Leagueable
  include GameStatsable
  
  def initialize(locations)
    @x = 1
    @locations = locations
    @games_data = CSV.read(@locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(@locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(@locations[:game_teams], headers: true, header_converters: :symbol)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  # Game statistics 
  def highest_total_score
    scores = @games_data.map do |row| 
      row[:away_goals].to_i + row[:home_goals].to_i 
    end
    scores.max
  end

  def lowest_total_score
    scores = @games_data.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i 
    end
    scores.min
  end

  def percentage_home_wins
    wins = 0
    total_games = 0

    @game_teams_data.each do |row|
        if row[:hoa] == 'home'
          
          if row[:result] == 'WIN'
            wins += 1
            total_games += 1
        
          elsif row[:result] == 'LOSS' 
            total_games += 1

          elsif row[:result] == 'TIE'
            total_games += 1
          end
        end
    end
      (wins / total_games.to_f).round(2)
  end

  def percentage_visitor_wins
    wins = 0
    total_games = 0

    @game_teams_data.each do |row|
        if row[:hoa] == 'away'
          
          if row[:result] == 'WIN'
            wins += 1
            total_games += 1
        
          elsif row[:result] == 'LOSS' 
            total_games += 1

          elsif row[:result] == 'TIE'
            total_games += 1
          end
        end
    end
      (wins / total_games.to_f).round(2)
  end

  def percentage_ties
    tie = 0
    total_games = 0

    @game_teams_data.each do |row|
        if row[:hoa] == 'away'
          
          if row[:result] == 'TIE'
            tie += 1
            total_games += 1
          elsif row[:result] == 'LOSS' 
            total_games += 1
          elsif row[:result] == 'WIN'
            total_games += 1
          end
        end
    end
      (tie / total_games.to_f).round(2)
  end

  def count_of_games_by_season    
    season_games = {}

    seasons = @games_data.map do |row|
      row[:season] 
    end
    seasons = seasons.uniq!
  
    seasons.each do |season|
      season_games[season] = 0
    end

    season_games.each do |season, games|
        @games_data.each do |row|
          # require 'pry';binding.pry
          if row[:season] == season
            season_games[season] += 1
          end 
        end
    end
    return season_games
  end

  def average_goals_per_game
    total_games = []
    @games_data.each do |row|
      total_games << row[:game_id]
    end
    total_goals = 0
    @games_data.each do |row|
      total_goals += (row[:away_goals].to_i + row[:home_goals].to_i)
    end
    (total_goals.to_f / total_games.count).round(2)
  end

  def average_goals_by_season
    seasons = Hash.new()
    @games_data.each do |row|
      seasons[row[:season]] = []
    end
    @games_data.each do |row|
      seasons[row[:season]] << (row[:away_goals].to_i + row[:home_goals].to_i)
    end
    average_goals_by_season = Hash.new()
    seasons.each do |season, goals|
      average_goals_by_season[season] = (goals.sum.to_f / goals.length).round(2)  
    end
    average_goals_by_season
  end
# League Statistics
  # def count_of_teams
  #   @teams_data.select { |team| team[:team_id] }.count
  # end

  # def best_offense 
  #   team_best_offense = team_average_goals.key(team_average_goals.values.max)
  #   find_team_name_by_id(team_best_offense)
  # end 

  # def worst_offense
  #   team_worst_offense = team_average_goals.key(team_average_goals.values.min)
  #   find_team_name_by_id(team_worst_offense)
  # end

  # def highest_scoring_visitor
  #   highest_score_visitor = team_away_average_goals.key(team_away_average_goals.values.max)
  #   find_team_name_by_id(highest_score_visitor)
  # end

  # def highest_scoring_home_team  
  #   highest_score_home_team = team_home_average_goals.key(team_home_average_goals.values.max)
  #   find_team_name_by_id(highest_score_home_team)
  # end

  # def lowest_scoring_visitor
  #   lowest_score_visitor = team_away_average_goals.key(team_away_average_goals.values.min)
  #   find_team_name_by_id(lowest_score_visitor)
  # end

  # def lowest_scoring_home_team
  #   lowest_score_home_team = team_home_average_goals.key(team_home_average_goals.values.min)
  #   find_team_name_by_id(lowest_score_home_team)
  # end
  
  # # Season Statistics
  # def winningest_coach(season)
  #   records = coach_records(season)
  #   populate_coach_records(season, records)
  #   winning_record(records).max_by { |team, win_percent| win_percent }[0].to_s
  # end

  # def worst_coach(season)
  #   records = coach_records(season)
  #   populate_coach_records(season, records)
  #   winning_record(records).min_by { |team, win_percent| win_percent }[0].to_s
  # end

  # def most_accurate_team(season)
  #   records = accuracy_records(season)
  #   populate_accuracy_records(season, records)
  #   find_team_name_by_id(most_accurate(records))
  # end

  # def least_accurate_team(season)
  #   records = accuracy_records(season)
  #   populate_accuracy_records(season, records)
  #   find_team_name_by_id(least_accurate(records))
  # end

  # def most_tackles(season)
  #   records = tackle_records(season)
  #   populate_tackle_records(season, records)
  #   find_team_name_by_id(best_tackling_team(records))
  # end

  # def fewest_tackles(season)
  #   records = tackle_records(season)
  #   populate_tackle_records(season, records)
  #   find_team_name_by_id(worst_tackling_team(records))
  # end

  # Team Statistics

  def team_info(given_team_id)
      all_team_info = @teams_data.select do |team|
         team[:team_id].to_s == given_team_id.to_s
      end[0]
      team_info_hash = {
        team_id: all_team_info[:team_id],
        franchise_id: all_team_info[:franchiseid],
        team_name: all_team_info[:teamname],
        abbreviation: all_team_info[:abbreviation],
        link: all_team_info[:link]
      }
  end

  def best_season(given_team_id)
    all_team_games = find_all_team_games(given_team_id)
    home_games = all_team_games.select { |game| game[:home_team_id] == given_team_id.to_s }
    away_games = all_team_games.select { |game| game[:away_team_id] == given_team_id.to_s }

    season_record = Hash.new{ |season, record | season[record] = [0.0, 0.0, 0.0] }
    home_games.each do |game|
      if game[:away_goals] > game[:home_goals]
        season_record[game[:season]][2] += 1
      elsif game[:away_goals] < game[:home_goals]
        season_record[game[:season]][0] += 1
      else
        season_record[game[:season]][1] += 1
      end
    end

    away_games.each do |game|
      if game[:away_goals] > game[:home_goals]
        season_record[game[:season]][0] += 1
      elsif game[:away_goals] < game[:home_goals]
        season_record[game[:season]][2] += 1
      else
        season_record[game[:season]][1] += 1
      end
    end
    best_season = season_record.max_by { |season, record| record[0] / (record[2] + record [1])}
    best_season[0]
  end

  def worst_season(given_team_id)
    all_team_games = find_all_team_games(given_team_id)
    home_games = all_team_games.select { |game| game[:home_team_id] == given_team_id.to_s }
    away_games = all_team_games.select { |game| game[:away_team_id] == given_team_id.to_s }

    season_record = Hash.new{ |season, record | season[record] = [0.0, 0.0, 0.0] }
    home_games.each do |game|
      if game[:away_goals] > game[:home_goals]
        season_record[game[:season]][2] += 1
      elsif game[:away_goals] < game[:home_goals]
        season_record[game[:season]][0] += 1
      else
        season_record[game[:season]][1] += 1
      end
    end

    away_games.each do |game|
      if game[:away_goals] > game[:home_goals]
        season_record[game[:season]][0] += 1
      elsif game[:away_goals] < game[:home_goals]
        season_record[game[:season]][2] += 1
      else
        season_record[game[:season]][1] += 1
      end
    end
    worst_season = season_record.min_by { |season, record| record[0] / (record[2] + record [1])}
    worst_season[0]
  end

  def average_win_percentage(given_team_id)
    all_team_games = find_all_team_games(given_team_id)
    home_games = all_team_games.select { |game| game[:home_team_id] == given_team_id.to_s }
    away_games = all_team_games.select { |game| game[:away_team_id] == given_team_id.to_s }

    wins_total_games = [0.0, 0.0]
    home_games.each do |game|
      if game[:away_goals] < game[:home_goals]
        wins_total_games[1] += 1
        wins_total_games[0] += 1
      else
        wins_total_games[1] +=1
        #tie
      end
    end

    away_games.each do |game|
      if game[:away_goals] > game[:home_goals]
        wins_total_games[0] += 1
        wins_total_games[1] += 1
      else
        wins_total_games[1] += 1
      end
    end
    win_percentage = ((wins_total_games[0] / wins_total_games[1])*100).round(2)
  end

  def most_goals_scored(given_team_id)
    all_team_games = find_all_team_games(given_team_id)
    home_games = all_team_games.select { |game| game[:home_team_id] == given_team_id.to_s }
    away_games = all_team_games.select { |game| game[:away_team_id] == given_team_id.to_s }
    goals_by_game = []
    home_games.each do |game|
      goals_by_game << game[:home_goals]
    end
    away_games.each do |game|
      goals_by_game << game[:away_goals]
    end
    goals_by_game.max
  end

  def fewest_goals_scored(given_team_id)
    0
  end

  def favorite_opponent(given_team_id)
    all_team_games = find_all_team_games(given_team_id)
    home_games = all_team_games.select { |game| game[:home_team_id] == given_team_id.to_s }
    away_games = all_team_games.select { |game| game[:away_team_id] == given_team_id.to_s }

    wins_and_losses = Hash.new{|opposing_id, head_to_head| opposing_id[head_to_head] = [0.0, 0.0]}
    home_games.each do |game|
      if game[:away_goals] > game[:home_goals]
        wins_and_losses[game[:away_team_id]][1] += 1
      elsif game[:away_goals] < game[:home_goals]
        wins_and_losses[game[:away_team_id]][0] += 1
      else
        #tie
      end
    end
    away_games.each do |game|
      if game[:away_goals] > game[:home_goals]
        wins_and_losses[game[:home_team_id]][0] += 1
      elsif game[:away_goals] < game[:home_goals]
        wins_and_losses[game[:home_team_id]][1] += 1
      else
        #tie
      end
    end

    #values are an array that has total games won and the total games played against
    wins_and_losses.delete(given_team_id.to_s)
    fav_opponent_array = wins_and_losses.max_by { |team, array| (array[0] - array [1])}
    rival_team_id = fav_opponent_array[0]
    #convert team id to name
    find_team_name_by_id(rival_team_id)
  end


  def rival(given_team_id)
    all_team_games = find_all_team_games(given_team_id)
    home_games = all_team_games.select { |game| game[:home_team_id] == given_team_id.to_s }
    away_games = all_team_games.select { |game| game[:away_team_id] == given_team_id.to_s }

    wins_and_losses = Hash.new{|opposing_id, head_to_head| opposing_id[head_to_head] = [0.0, 0.0]}
    home_games.each do |game|
      if game[:away_goals] > game[:home_goals]
        wins_and_losses[game[:away_team_id]][1] += 1
      elsif game[:away_goals] < game[:home_goals]
        wins_and_losses[game[:away_team_id]][0] += 1
      else
        #tie
      end
    end

    away_games.each do |game|
      if game[:away_goals] > game[:home_goals]
        wins_and_losses[game[:home_team_id]][0] += 1
      elsif game[:away_goals] < game[:home_goals]
        wins_and_losses[game[:home_team_id]][1] += 1
      else
        #tie
      end
    end

    #values are an array that has total games won and the total games played against
    wins_and_losses.delete(given_team_id.to_s)
    fav_opponent_array = wins_and_losses.min_by { |team, array| (array[0] - array [1])}
    rival_team_id = fav_opponent_array[0]
    #convert team id to name

    find_team_name_by_id(rival_team_id)
  end
  # Helper Methods Below

  def find_all_team_games(given_team_id)
    away_games_by_team(given_team_id) + home_games_by_team(given_team_id)
  end

  def away_games_by_team(given_team_id)
    @games_data.find_all do |team|
      team[:away_team_id] == given_team_id.to_s
    end
  end

  def home_games_by_team(given_team_id)
    @games_data.find_all do |team|
      team[:home_team_id] == given_team_id.to_s
    end
  end

  def find_team_name_by_id(id_number)
    team_name = nil
    @teams_data.each do |row|
      team_name = row[:teamname] if row[:team_id] == id_number.to_s
    end
    team_name
  end
end

