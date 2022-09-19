require 'csv'
require 'pry'
class StatTracker
  attr_reader :games_data, :teams_data, :game_teams_data

  def initialize(locations)
    @games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    @league = League.new(@teams_data, @game_teams_data)
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
  













































  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  def winningest_coach(campaign)
    coached_games_in_season = Hash.new(0)
    coach_wins_in_season = Hash.new(0)
    game_results_percentage = Hash.new
    
    season_data(campaign).find_all do |row|
      if row[:result] == "WIN"
        coach_wins_in_season [row[:head_coach]] += 1
      end
    end
    coach_wins_in_season 

    season_data(campaign).find_all do |row|
      if coach_wins_in_season.has_key?(row[:head_coach])
        coached_games_in_season[row[:head_coach]] += 1
      end
    end
    coached_games_in_season 

    game_results_percentage.update(coached_games_in_season,coach_wins_in_season) do |coach, games_coached, games_won| 
      (games_won.fdiv(games_coached)).round(4)
    end
    winning_coach = game_results_percentage.max_by { |coach, percentage| percentage }

    winning_coach[0]
  end

  def worst_coach(campaign)
    coached_games_in_season = Hash.new(0)
    coach_wins_in_season = Hash.new(0)
    game_results_percentage = Hash.new
    
    season_data(campaign).select do |row|
      if row[:result] != "WIN"
        coach_wins_in_season [row[:head_coach]] += 1
      end
    end
    coach_wins_in_season 

    season_data(campaign).select { |row| coached_games_in_season[row[:head_coach]] += 1}
      coached_games_in_season 

    game_results_percentage.update(coached_games_in_season,coach_wins_in_season) do |coach, games_coached, games_won| 
      (games_won.fdiv(games_coached)).round(4)
    end
    worst_coach = game_results_percentage.max_by { |coach, percentage| percentage }
      
    worst_coach[0]
  end

  def most_accurate_team(campaign)
    team_season_goals_count = Hash.new(0)
    team_season_shots_count = Hash.new(0)
    shot_efficiency = Hash.new

    season_data(campaign).find_all do |row|
      goals = row[:goals].to_i
      shots = row[:shots].to_i

      team_season_goals_count[row[:team_id]] += goals
      team_season_shots_count[row[:team_id]] += shots
    end
    team_season_goals_count
    team_season_shots_count

    shot_efficiency.update(team_season_goals_count,team_season_shots_count) do |team, goals_made, shots_taken|
      goals_made.fdiv(shots_taken).round(4)
    end
    team_efficiency = shot_efficiency.max_by { |coach, percentage| percentage }
    
    team_name_from_id_average(team_efficiency)
  end

  def least_accurate_team	(campaign)
    team_season_goals_count = Hash.new(0)
    team_season_shots_count = Hash.new(0)
    shot_efficiency = Hash.new

    season_data(campaign).each do |row|
      goals = row[:goals].to_i
      shots = row[:shots].to_i

      team_season_goals_count[row[:team_id]] += goals
      team_season_shots_count[row[:team_id]] += shots
    end
    team_season_goals_count
    team_season_shots_count

    shot_efficiency.update(team_season_goals_count,team_season_shots_count) do |team, goals_made, shots_taken|
      goals_made.fdiv(shots_taken).round(4)
    end
    team_efficiency = shot_efficiency.min_by { |coach, percentage| percentage }

    team_name_from_id_average(team_efficiency)
  end

  def most_tackles(campaign)
    team_total_tackles = Hash.new(0)
    season_data(campaign)
    
    season_data(campaign).each do |row|
      tackles = row[:tackles].to_i
      team_total_tackles[row[:team_id]] += tackles
    end
    number_of_team_tackle = team_total_tackles.max_by { |coach, percentage| percentage }
    
    team_name_from_id_average(number_of_team_tackle)
  end

  def fewest_tackles(campaign)
    team_total_tackles = Hash.new(0)
    season_data(campaign)
    
    season_data(campaign).each do |row|
      tackles = row[:tackles].to_i
      team_total_tackles[row[:team_id]] += tackles
    end
    team_tackle = team_total_tackles.min_by { |coach, percentage| percentage }
    team_name_from_id_average(team_tackle)
  end

  def team_name_from_id_average(data)
    @teams_data.each do |row|
      if data[0] == row[:team_id]
        return row[:teamname]
      end
    end
  end

  def season_data(campaign)
    season = Set.new
    @game_teams_data.each do |row|      
      row.find_all do |game_id|
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
    
    campaign.each do |year|
      a = @games_data.find_all do |row|
        row[:season] == year &&
        (row[:away_team_id] == team || row[:home_team_id] == team)
      end

      a.each do |game_row|
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
    
    campaign.each do |year|
      a = @games_data.find_all do |row|
        row[:season] == year &&
        (row[:away_team_id] == team || row[:home_team_id] == team)
      end

      a.each do |game_row|
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
    # end of team class
end
