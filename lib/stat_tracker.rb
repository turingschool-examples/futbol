require 'csv'

class StatTracker
  attr_reader :data_array,
              :games,
              :teams,
              :game_teams


  def self.from_csv(locations)
    @data_array = locations.values.map {|location| location }
    @stat_tracker = StatTracker.new(@data_array)
  end

  def initialize(data_array)
    @data_array = data_array
    @games = CSV.read @data_array[0], headers: true, header_converters: :symbol
    @teams = CSV.read @data_array[1], headers: true, header_converters: :symbol
    @game_teams = CSV.read @data_array[2], headers: true, header_converters: :symbol
  end

  def highest_total_score
    @games.map {|row| row[:home_goals].to_i + row[:away_goals].to_i}.max
  end

  def average_goals_per_game
    total_games = @games.map { |row| row[:game_id]}.count
    total_goals = @games.map { |row| row[:home_goals].to_i + row[:away_goals].to_i}.sum
    (total_goals.to_f / total_games).round(2)
  end


  def average_goals_by_season
    average_goals_by_season = {}
    all_seasons = @games.map { |row| row[:season]}
    all_seasons.uniq.each do |season|
      all_games = @games.find_all { |row| season == row[:season]}
        total_score = all_games.map { |row| row[:home_goals].to_i + row[:away_goals].to_i }
          average_goals_by_season[season] = ((total_score.sum.to_f / all_games.count.to_f).round(2))

    end 
    average_goals_by_season
  end 

  def count_of_games_by_season
    count_of_games_by_season = Hash.new(0)
         seasons = @games.map { |row| row[:season]}.tally
  end

  def percentage_home_wins
    tally = 0
    @game_teams.find_all do |row|
       tally += 1 if (row[:hoa] == "home" && row[:result] == "WIN") || (row[:hoa] == "away" && row[:result] == "LOSS")
    end
    (tally.to_f / @game_teams.count.to_f).round(2)
  end

  def percentage_visitor_wins
    tally = 0
    @game_teams.find_all do |row|
       tally += 1 if (row[:hoa] == "away" && row[:result] == "WIN") || (row[:hoa] == "home" && row[:result] == "LOSS")
    end
    (tally.to_f / @game_teams.count.to_f).round(2)
  end

  def percentage_ties
    tally = 0 
    @game_teams.find_all do |row|
       tally += 1 if (row[:hoa] == "away" && row[:result] == "TIE") || (row[:hoa] == "home" && row[:result] == "TIE")
    end
    (tally.to_f / @game_teams.count.to_f).round(2)
  end
  
  def winningest_coach(season_id)
    wins_hash = Hash.new(0)
    total_games_hash = Hash.new(0)
    games_list = list_games_by_season(season_id)
    @game_teams.each do |row|
      if games_list.include?(row[:game_id])
        wins_hash[row[:head_coach]] += 1 if row[:result] == "WIN"
        total_games_hash[row[:head_coach]] += 1 if row[:result]
      end
    end
    
    additional_hash = {}
    total_games_hash.each do |key, value|
      wins_hash.each do |key_v, value_v|
        if key == key_v
          percent = (value_v / value.to_f)
          additional_hash[key] = percent
        end
      end
    end
    additional_hash.max_by{|k,v| v}[0]
  end
  
  def worst_coach(season_id)
    wins_hash = Hash.new(0)
    total_games_hash = Hash.new(0)
    games_list = list_games_by_season(season_id)
    
    @game_teams.each do |row|
      if games_list.include?(row[:game_id])
        wins_hash[row[:head_coach]] += 1 if row[:result] == "WIN"
        wins_hash[row[:head_coach]] += 0 if row[:result]
        total_games_hash[row[:head_coach]] += 1 if row[:result]
      end
    end
    
    additional_hash = {}
    total_games_hash.each do |key, value|
      wins_hash.each do |key_v, value_v|
        if key == key_v
          percent = (value_v / value.to_f)
          additional_hash[key] = percent
        end
      end
    end
    #require 'pry'; binding.pry
    additional_hash.min_by{|k,v| v}[0]
  end

  def list_games_by_season(season_id)
    games_list = []
    @games.each do |row|
      games_list << row[:game_id] if row[:season] == season_id
    end
    games_list
  end
  

  def highest_scoring_visitor
    scoring_breakdown = {}
    teams = @teams.map { |team| team[:team_id] }
    teams.each do |team|
      all_away_games = @games.find_all { |game| game[:away_team_id] == team}
        total_goals = all_away_games.map { |away_game| away_game[:away_goals].to_i}.sum
        if all_away_games.count != 0
        average_away_goals = total_goals.to_f / all_away_games.count.to_f
        scoring_breakdown[team] = average_away_goals.to_f.round(2)
        else 
          nil
        end 
    end 

    leading_team_id = nil
    scoring_breakdown.each { |key, value| leading_team_id = key if  value == scoring_breakdown.values.max }
    final_team = @teams.select { |team| team[:team_id] == leading_team_id}
    final_team[0][:teamname]
  end

  def lowest_scoring_visitor 
    scoring_breakdown = {}
    teams = @teams.map { |team| team[:team_id] }
    teams.each do |team|
      all_away_games = @games.find_all { |game| game[:away_team_id] == team}
        total_goals = all_away_games.map { |away_game| away_game[:away_goals].to_i}.sum
        if all_away_games.count != 0
        average_away_goals = total_goals.to_f / all_away_games.count.to_f
        scoring_breakdown[team] = average_away_goals.to_f.round(3)
        else 
          nil
        end 
    end 

    last_team_id = nil
    scoring_breakdown.each { |key, value| last_team_id = key if  value == scoring_breakdown.values.min}
    final_team = @teams.select { |team| team[:team_id] == last_team_id}
    final_team[0][:teamname]
  end

  def highest_scoring_home_team
    scoring_breakdown = {}
    teams = @teams.map { |team| team[:team_id] }
    teams.each do |team|
      all_home_games = @games.find_all { |game| game[:home_team_id] == team}
        total_goals = all_home_games.map { |home_game| home_game[:home_goals].to_i}.sum
        if all_home_games.count != 0
        average_home_goals = total_goals.to_f / all_home_games.count.to_f
        scoring_breakdown[team] = average_home_goals.to_f.round(2)
        else 
          nil
        end 
    end 

    leading_team_id = nil
    scoring_breakdown.each { |key, value| leading_team_id = key if  value == scoring_breakdown.values.max }
    final_team = @teams.select { |team| team[:team_id] == leading_team_id}
    final_team[0][:teamname]
  end

  def lowest_scoring_home_team
    scoring_breakdown = {}
    teams = @teams.map { |team| team[:team_id] }
    teams.each do |team|
      all_home_games = @games.find_all { |game| game[:home_team_id] == team}
        total_goals = all_home_games.map { |home_game| home_game[:home_goals].to_i}.sum
        if all_home_games.count != 0
        average_home_goals = total_goals.to_f / all_home_games.count.to_f
        scoring_breakdown[team] = average_home_goals.to_f.round(3)
        else 
          nil
        end 
    end 

    last_team_id = nil
    scoring_breakdown.each { |key, value| last_team_id = key if  value == scoring_breakdown.values.min}
    final_team = @teams.select { |team| team[:team_id] == last_team_id}
    final_team[0][:teamname]
  end

  def team_info(team_id)
    info = @teams.find {|team| team[:team_id] == team_id}
    { 'team_id' => info[:team_id], 'franchise_id' => info[:franchiseid], 'team_name' => info[:teamname], 'abbreviation' => info[:abbreviation], 'link' => info[:link] }

  end

  def average_win_percentage(team_id)
    games_by_team = @game_teams.find_all {|game| game[:team_id] == team_id}
    total = games_by_team.count
    wins = 0
    games_by_team.each do |game|
      wins += 1 if game[:result] == "WIN"
    end
    (wins/total.to_f).round(2)
  end
end