require 'csv'
require 'pry'
class StatTracker
  attr_reader :games_data, :teams_data, :game_teams_data

  def initialize(locations)
    @games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def total_game_goals
    @games_data.map {|row| row[:away_goals].to_i + row[:home_goals].to_i}
  end

  def highest_total_score
    total_game_goals.max
  end

  def lowest_total_score
    total_game_goals.min
  end

  def percentage_home_wins
    home_wins =0
    @games_data.each { |game| home_wins += 1 if game[:away_goals].to_i < game[:home_goals].to_i}
    (home_wins.to_f/games_data.count).round(2)
  end

  def percentage_visitor_wins
    visitor_wins =0
    @games_data.each { |game| visitor_wins += 1 if game[:away_goals].to_i > game[:home_goals].to_i}
    (visitor_wins.to_f/games_data.count).round(2)
  end

  def percentage_ties
    ties =0 
    @games_data.each {|game| ties += 1 if game[:away_goals].to_i == game[:home_goals].to_i}
    (ties.to_f/games_data.count).round(2)
  end

  def count_of_games_by_season
    games_by_season = {}
    @games_data.each {|game|
      games_by_season[game[:season]] += 1 if games_by_season.include?(game[:season])
      games_by_season[game[:season]] = 1 if !games_by_season.include?(game[:season])
    }
    games_by_season
  end
  
  def count_of_goals_by_season
    goals_by_season = {}
    @games_data.each { |game|
      if goals_by_season.include?(game[:season])
        goals_by_season[game[:season]] += ([game[:away_goals].to_f]+[game[:home_goals].to_f]).sum
      elsif !goals_by_season.include?(game[:season])
        goals_by_season[game[:season]] = ([game[:away_goals].to_f]+[game[:home_goals].to_f]).sum
      end
    }
    goals_by_season
  end
  
  def average_goals_per_game
    (total_game_goals.sum / @games_data.count.to_f).round(2)
  end
  
  def average_goals_by_season
    average_goals = {}  
    count_of_goals_by_season.each {|season, goals|
      count_of_games_by_season.each {|season_number, games|
        average_goals[season_number] = (goals/games).round(2) if season_number == season
        }}
    average_goals
  end

  def count_of_games_by_season
    games_by_season = {}
    @games_data.each do |row|
      if games_by_season.include?(row[:season])
        games_by_season[row[:season]] += 1
      elsif games_by_season.include?(row[:season]) == false
        games_by_season[row[:season]] = 1
      end
    end
    games_by_season
  end

  



















































































































































  def count_of_teams
    @teams_data.count 
  end

  # def team_goals_per_game

  # end

  # def team_average_goals_per_game

  # end

  def best_offense
    team_goals = Hash.new
    @game_teams_data.each do |row|
      if team_goals[row[:team_id]] != nil
        team_goals[row[:team_id]].push(row[:goals].to_i)
      else
        team_goals[row[:team_id]] = [row[:goals].to_i]
      end
    end

    team_average = Hash.new
    team_goals.each do |team_id, goals_per_game|
      team_average[team_id] = (goals_per_game.sum.to_f / goals_per_game.size.to_f).round(3)
    end
    
    highest_average = team_average.max_by{ |id, average| average }

    @teams_data.each do |row|
      if highest_average[0] == row[:team_id]
        return row[:teamname]
      end
    end
  end

  def worst_offense
    team_goals = Hash.new
    @game_teams_data.each do |row|
      if team_goals[row[:team_id]] != nil
        team_goals[row[:team_id]].push(row[:goals].to_i)
      else
        team_goals[row[:team_id]] = [row[:goals].to_i]
      end
    end

    team_average = Hash.new
    team_goals.each do |team_id, goals_per_game|
      team_average[team_id] = (goals_per_game.sum.to_f / goals_per_game.size.to_f).round(3)
    end
    
    lowest_average = team_average.min_by{ |id, average| average }

  def percentage_ties
    ties = 0
    @games_data.each do |row|
      ties += 1 if row[:away_goals].to_i == row[:home_goals].to_i
    end
    (ties.to_f / games_data.count).round(2)
  end
  # end of game class

  # league statistics

  # team class

  def team_info(index)
    team_info_hash = {}
    @teams_data.map do |row|
      next unless row[:team_id] == index

      team_info_hash[:team_id.to_s] = row[:team_id]
      team_info_hash[:franchise_id.to_s] = row[:franchiseid]
      team_info_hash[:team_name.to_s] = row[:teamname]
      team_info_hash[:abbreviation.to_s] = row[:abbreviation]
      team_info_hash[:link.to_s] = row[:link]
    end
    team_info_hash
  end
  # def best_season(team)
  #   @games_data.map do |row|
  #     if row[:team_id] == team
  #       if row[:result] == WIN
  #         row[:seasonid] += 1
  #       end
  #     end
  #   end

  # end
  # def worst_season
  # end
    def average_win_percentage(team)
    win_count = 0
    loss_count = 0
    total_games = 0
      @games_data.map do |row|
        if row[:away_team_id] == team
          if row[:away_goals] > row[:home_goals]
            win_count += 1
          else
            loss_count += 1
          end
        elsif row[:home_team_id] == team
          if row[:home_goals] > row[:away_goals]
            win_count += 1
          else
            loss_count += 1
          end
        end
      end    
      total_games = (win_count + loss_count)
      (win_count.to_f / total_games.to_f).round(2)
    end
    def most_goals_scored(team)
      score_array = [] 
      @games_data.map do |row|
        if row[:away_team_id] == team
          score_array << row[:away_goals]
        elsif row[:home_team_id] == team
          score_array << row[:home_goals]
        end
      end
      score_array.sort!
      score_array.pop.to_i
    end

    def fewest_goals_scored(team) 
      score_array = [] 
      @games_data.map do |row|
        if row[:away_team_id] == team
          score_array << row[:away_goals]
        elsif row[:home_team_id] == team
          score_array << row[:home_goals]
        end
      end
      score_array.sort!
      score_array.shift.to_i
    end

    def favorite_opponent(team)
      team_wins = {}
      team_losses = {}
      @games_data.map do |row|
        if !team_wins.has_key?(row[:home_team_id])
          team_wins[row[:home_team_id]] = 0 
        elsif !team_wins.has_key?(row[:away_team_id])
          team_wins[row[:away_team_id]] = 0 
        end  
        if !team_losses.has_key?(row[:home_team_id])  
          team_losses[row[:home_team_id]] = 0
        elsif !team_losses.has_key?(row[:away_team_id])
          team_losses[row[:away_team_id]] = 0
        end
      end 
      @games_data.map do |row|
        if row[:away_team_id] == team
          if row[:away_goals] >= row[:home_goals]
            team_losses[row[:home_team_id]] += 1  
          else
            team_wins[row[:home_team_id]] += 1
          end
        elsif row[:home_team_id] == team
          if row[:home_goals] >= row[:away_goals]
            team_losses[row[:away_team_id]] += 1
          else
            team_wins[row[:away_team_id]] += 1
          end
        end
      end
      min_win_rate = 100
      min_win_rate_team = nil
      team_wins.each do |key, value|
        if key != team

          total_games = value + team_losses[key]
          win_rate = value.to_f / total_games
          if win_rate < min_win_rate
            min_win_rate = win_rate
            min_win_rate_team = key
          end
        end
      end
      # team_name_from_id_average
      min_win_rate_team
    end

    def rival(team)
      team_wins = {}
      team_losses = {}
      @games_data.map do |row|
        if !team_wins.has_key?(row[:home_team_id])
          team_wins[row[:home_team_id]] = 0 
        elsif !team_wins.has_key?(row[:away_team_id])
          team_wins[row[:away_team_id]] = 0 
        end  
        if !team_losses.has_key?(row[:home_team_id])  
          team_losses[row[:home_team_id]] = 0
        elsif !team_losses.has_key?(row[:away_team_id])
          team_losses[row[:away_team_id]] = 0
        end
      end 
      @games_data.map do |row|
        if row[:away_team_id] == team
          if row[:away_goals] >= row[:home_goals]
            team_losses[row[:home_team_id]] += 1  
          else
            team_wins[row[:home_team_id]] += 1
          end
        elsif row[:home_team_id] == team
          if row[:home_goals] >= row[:away_goals]
            team_losses[row[:away_team_id]] += 1
          else
            team_wins[row[:away_team_id]] += 1
          end
        end
      end
    
      max_win_rate = 0
      max_win_rate_team = nil
      team_wins.each do |key, value|
        if key != team

          total_games = value + team_losses[key]
          win_rate = value.to_f / total_games
          if win_rate > max_win_rate
            max_win_rate = win_rate
            max_win_rate_team = key
          end
        end
      end
      # team_name_from_id_average
      max_win_rate_team
    end
    # end of team class
end
