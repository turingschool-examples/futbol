require 'csv'
require 'pry'
class StatTracker
  attr_reader :games_data, :teams_data, :game_teams_data

  def initialize(locations)
    @games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    @league = League.new(@teams_data, @game_teams_data)
    @game = Game.new(@games_data)
    @season = Season.new(@teams_data, @game_teams_data)
    @team = Team.new(@games_data, @teams_data, @game_teams_data)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def total_game_goals
    @game.total_game_goals
  end

  def highest_total_score
    @game.highest_total_score
  end

  def lowest_total_score
    @game.lowest_total_score
  end

  def percentage_home_wins
    @game.percentage_home_wins
  end

  def percentage_visitor_wins
    @game.percentage_visitor_wins
  end

  def percentage_ties
    @game.percentage_ties
  end

  def count_of_games_by_season
    @game.count_of_games_by_season
  end
  
  def count_of_goals_by_season
    @game.count_of_goals_by_season
  end
  
  def average_goals_per_game
    @game.average_goals_per_game
  end
  
  def average_goals_by_season
    @game.average_goals_by_season
  end

  def count_of_games_by_season
    @game.count_of_games_by_season
  end

  def count_of_teams
    @league.count_of_teams
  end

  def best_offense
    @league.best_offense
  end

  def worst_offense
    @league.worst_offense
  end

  def highest_scoring_visitor
    @league.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @league.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @league.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league.lowest_scoring_home_team
  end



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
    team_name_from_id_average(min_win_rate_team.split)
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
    
    team_name_from_id_average(max_win_rate_team.split)
  end
  
  def winningest_coach(campaign)
    @season.winningest_coach(campaign)
  end

  def worst_coach(campaign)
    @season.worst_coach(campaign)
  end

  def most_accurate_team(campaign)
    @season.most_accurate_team(campaign)
  end

  def least_accurate_team	(campaign)
    @season.least_accurate_team(campaign)
  end

  def most_tackles(campaign)
    @season.most_tackles(campaign)
  end

  def fewest_tackles(campaign)
    @season.fewest_tackles(campaign)
  end

  def team_name_from_id_average(data)
    @teams_data.find do |row|
      if data[0] == row[:team_id]
        return row[:teamname]
      end
    end
  end

  def season_data(campaign)
    season = Set.new
    @game_teams_data.select do |row|      
      row.select do |game_id|
        if campaign.scan(/.{4}/).shift == row[:game_id].scan(/.{4}/).shift
          season << row
        end
      end
    end
    season 
  end

  #Method returns best season for each team
  def best_season(team)
    campaign = @games_data.map { |row| row[:season] }.uniq
  
    hash = Hash.new do |h,k| 
      h[k] = { games_won: 0, games_played: 0 } 
    end
    
    campaign.select do |year|
      a = @games_data.select do |row|
        row[:season] == year &&
        (row[:away_team_id] == team || row[:home_team_id] == team)
      end

      a.select do |game_row|
        b = @game_teams_data.find do |game_team_row|
          game_team_row[:game_id] == game_row[:game_id] && game_team_row[:team_id] == team 
        end 
        hash[year][:games_won] += 1 if b[:result] == "WIN"
        hash[year][:games_played] += 1
      end
    end
    
    season_average_percentage = Hash.new
    
    hash.each do |year, totals| 
      season_average_percentage[year] = (totals[:games_won].to_f / totals[:games_played]).round(4) 
    end
    
    season_record = season_average_percentage.max_by { |year, percentage| percentage }
    season_record[0]
    # require 'pry';binding.pry

  end

  #Method returns best season for each team
  def worst_season (team)
    campaign = @games_data.map { |row| row[:season] }.uniq
  
    hash = Hash.new do |h,k| 
      h[k] = { games_won: 0, games_played: 0 } 
    end
    
    campaign.select do |year|
      team_games_played_in_a_season = @games_data.select do |row|
        row[:season] == year &&
        (row[:away_team_id] == team || row[:home_team_id] == team)
      end

      team_games_played_in_a_season.select do |game_row|
        b = @game_teams_data.find do |game_team_row|
          game_team_row[:game_id] == game_row[:game_id] && game_team_row[:team_id] == team 
        end 
        hash[year][:games_won] += 1 if b[:result] == "WIN"
        hash[year][:games_played] += 1
      end
    end
    
    season_average_percentage = Hash.new
    
    hash.each do |year, totals| 
      season_average_percentage[year] = (totals[:games_won].to_f / totals[:games_played]).round(4) 
    end
    
    season_record = season_average_percentage.min_by { |year, percentage| percentage }
    season_record[0]
  end
end