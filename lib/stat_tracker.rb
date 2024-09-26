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

  def lowest_total_score
    @games.map {|row| row[:home_goals].to_i + row[:away_goals].to_i}.min
  end

  def count_of_teams
   @teams.count
  end

  def nested_hash_creator
    Hash.new {|h,k| h[k] = Hash.new(0) }
  end

  def team_id_to_name(id)
    @teams.find { |team| team[:team_id] == id }[:teamname]
  end


  

  def best_offense
    hash1 = nested_hash_creator
    hash2 = Hash.new(0)
    game_teams.each do |row|
      hash1[row[:team_id]][:games] += 1
      hash1[row[:team_id]][:goals] += row[:goals].to_i
    end
    hash1.each do |key, value|
      hash2[key] =  value[:goals].to_f / value[:games].to_f
    end

    highest_goals_average = hash2.values.max

    highest_scoring_id = hash2.find do |key, value|
      value == highest_goals_average
    end[0]

    team_id_to_name(highest_scoring_id)
  end

  def worst_offense
    hash1 = nested_hash_creator
    hash2 = Hash.new(0)
    game_teams.each do |row|
      hash1[row[:team_id]][:games] += 1
      hash1[row[:team_id]][:goals] += row[:goals].to_i
    end
    hash1.each do |key, value|
      hash2[key] =  value[:goals].to_f / value[:games].to_f
    end

    lowest_goals_average = hash2.values.min
    lowest_scoring_id = hash2.find do |key, value|
      value == lowest_goals_average
    end[0]

    team_id_to_name(lowest_scoring_id)
  end

  def most_tackles(season_id)
    teams_tackles_hash = Hash.new(0)
    games_list = list_games_by_season(season_id)
  
    @game_teams.each do |row|
      if games_list.include?(row[:game_id])
        teams_tackles_hash[row[:team_id]] += row[:tackles].to_i
      end
    end

    highest_tackling_team_id = teams_tackles_hash.max_by{|k,v| v}[0]
    team_id_to_name(highest_tackling_team_id)   
  end 

  def average_goals_per_game
    total_games = @games.map { |row| row[:game_id]}.count
    total_goals = @games.map { |row| row[:home_goals].to_i + row[:away_goals].to_i}.sum
    (total_goals.to_f / total_games).round(2)
  end

  def fewest_tackles(season_id)
    teams_tackles_hash = Hash.new(0)
    games_list = list_games_by_season(season_id)

    @game_teams.each do |row|
      if games_list.include?(row[:game_id])
        teams_tackles_hash[row[:team_id]] += row[:tackles].to_i
      end
    end
    
    lowest_tackling_team_id = teams_tackles_hash.min_by{|k,v| v}[0]
    team_id_to_name(lowest_tackling_team_id)
  end


  def list_games_by_season(season_id)
    games_list = []
    @games.each do |row|
      games_list << row[:game_id] if row[:season] == season_id
    end
    games_list
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

  def best_season(team_id)
    games_won_and_played_hash = nested_hash_creator
    chosen_teams_games = @game_teams.find_all {|game| game[:team_id] == team_id }
    chosen_teams_games.each do |game|
      @games.each do |row|
        if game[:game_id] == row[:game_id] && game[:result] == 'WIN'
        games_won_and_played_hash[row[:season]]['wins'] += 1 
        elsif game[:game_id] == row[:game_id]
        games_won_and_played_hash[row[:season]]['not wins'] += 1
        end
      end
    end
    win_percents_by_season = games_won_and_played_hash.map do |key, value|
      [key, value["wins"].to_f / (value["wins"].to_f + value["not wins"].to_f )]
    end  
    win_percents_by_season.max_by{|k,v| v}[0]
  
  end

  def worst_season(team_id)
    games_won_and_played_hash = nested_hash_creator
    chosen_teams_games = @game_teams.find_all {|game| game[:team_id] == team_id }
    chosen_teams_games.each do |game|
      @games.each do |row|
        if game[:game_id] == row[:game_id] && game[:result] == 'WIN'
        games_won_and_played_hash[row[:season]]['wins'] += 1 
        elsif game[:game_id] == row[:game_id]
        games_won_and_played_hash[row[:season]]['not wins'] += 1
        end
      end
    end
    win_percents_by_season = games_won_and_played_hash.map do |key, value|
      [key, value["wins"].to_f / (value["wins"].to_f + value["not wins"].to_f )]
    end  
    win_percents_by_season.min_by{|k,v| v}[0]
  end

  def favorite_opponent(team_id)
    
    all_wins = @game_teams.find_all { |game| game[:team_id] == team_id && game[:result] == "WIN"}
    all_games = @games.find_all { |game| game[:home_team_id] == team_id || game[:away_team_id] == team_id} 
    all_game_ids = all_wins.map {|game| game[:game_id]}

    all_games_opposing_team_ids = []
      all_games.each do |game| 
        if team_id == game[:home_team_id]
          all_games_opposing_team_ids << game[:away_team_id]
        else 
          all_games_opposing_team_ids << game[:home_team_id]
        end
      end

    all_games_hash = all_games_opposing_team_ids.tally

    all_games = []
    all_game_ids.each do |game_id|
      @games.each do |game| 
        if game_id == game[:game_id]
          all_games << game 
        end
      end 
    end 

    opposing_team_ids = []
      all_games.each do |game| 
        if team_id == game[:home_team_id]
          opposing_team_ids << game[:away_team_id]
        else 
          opposing_team_ids << game[:home_team_id]
        end
      end

    id_hash = opposing_team_ids.tally

    final_breakdown = {}
    id_hash.each do |id, value| 
      all_games_hash.each do |game, games_value|
        if id == game
          final_breakdown[id] = (value.to_f / games_value.to_f).round(3)
        end
      end
    end
    favorite_opponent_id = nil
    final_breakdown.select { |id, win_percentage| favorite_opponent_id = id if win_percentage == final_breakdown.values.max}

    team_id_to_name(favorite_opponent_id)
  end

  def rival(team_id)
    all_losses = @game_teams.find_all { |game| game[:team_id] == team_id && game[:result] == "LOSS"}
    all_games = @games.find_all { |game| game[:home_team_id] == team_id || game[:away_team_id] == team_id} 
    all_game_ids = all_losses.map {|game| game[:game_id]}

    all_games_opposing_team_ids = []
      all_games.each do |game| 
        if team_id == game[:home_team_id]
          all_games_opposing_team_ids << game[:away_team_id]
        else 
          all_games_opposing_team_ids << game[:home_team_id]
        end
      end

    all_games_hash = all_games_opposing_team_ids.tally

    all_games = []
    all_game_ids.each do |game_id|
      @games.each do |game| 
        if game_id == game[:game_id]
          all_games << game 
        end
      end 
    end 

    opposing_team_ids = []
      all_games.each do |game| 
        if team_id == game[:home_team_id]
          opposing_team_ids << game[:away_team_id]
        else 
          opposing_team_ids << game[:home_team_id]
        end
      end

    id_hash = opposing_team_ids.tally

    final_breakdown = {}
    id_hash.each do |id, value| 
      all_games_hash.each do |game, games_value|
        if id == game
          final_breakdown[id] = (value.to_f / games_value.to_f).round(3)
        end
      end
    end
    favorite_opponent_id = nil
    final_breakdown.select { |id, win_percentage| favorite_opponent_id = id if win_percentage == final_breakdown.values.max}

    team_id_to_name(favorite_opponent_id)
  end
end












