require 'csv'

class StatTracker
  attr_reader :locations,
              :games_data,
              :teams_data,
              :game_teams_data

  def initialize(locations)
    @locations = locations
    @games_data = CSV.read(@locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(@locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(@locations[:game_teams], headers: true, header_converters: :symbol)
  end

  def self.from_csv(locations)
    new_stat_tracker = StatTracker.new(locations)#games_data, teams_data, game_teams_data)
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
    new_hash = Hash.new()
    @games_data.each do |row|
      new_hash[row[:season]] = []
    end
    @games_data.each do |row|
      new_hash[row[:season]] << (row[:away_goals].to_i + row[:home_goals].to_i)
    end
    average_goals_by_season = Hash.new()
    new_hash.each do |season, goals|
      average_goals_by_season[season] = (goals.sum.to_f / goals.length).round(2)  
    end
    average_goals_by_season
  end
# League Statistics
  def count_of_teams
    teams = []
    @teams_data.select do |team|
      teams << team[:team_id] 
    end
    teams.count
  end

  def best_offense 
    teams = Hash.new()
    @game_teams_data.each do |row|
      teams[row[:team_id]] = []
    end
    @game_teams_data.each do |row|
      teams[row[:team_id]] << row[:goals].to_i 
    end
    team_average_goals = Hash.new()
    teams.each do |team, goals|
      team_average_goals[team] = (goals.sum.to_f / goals.length).round(2)
    end
    team_best_offense = team_average_goals.key(team_average_goals.values.max)
    find_team_name_by_id(team_best_offense)
  end 

  def worst_offense # team w/ lowest average goals scored per game.
    teams = Hash.new()
    @game_teams_data.each do |row|
      teams[row[:team_id]] = []
    end
    @game_teams_data.each do |row|
      teams[row[:team_id]] << row[:goals].to_i 
    end
    team_average_goals = Hash.new()
    teams.each do |team, goals|
      team_average_goals[team] = (goals.sum.to_f / goals.length).round(2)
    end
    team_worst_offense = team_average_goals.key(team_average_goals.values.min)
    find_team_name_by_id(team_worst_offense)
  end

  def highest_scoring_visitor
    teams = Hash.new()
    @game_teams_data.each do |row|
      teams[row[:team_id]] = []
    end
    @game_teams_data.each do |row|
      if row[:hoa] == "away"
        teams[row[:team_id]] << row[:goals].to_i
      end
    end
    team_average_goals = Hash.new()
    teams.each do |team, goals|
      team_average_goals[team] = (goals.sum.to_f / goals.length).round(2)
    end
    highest_score_visitor = team_average_goals.key(team_average_goals.values.max)
    find_team_name_by_id(highest_score_visitor)
  end

  def highest_scoring_home_team
    teams = Hash.new()
    @game_teams_data.each do |row|
      teams[row[:team_id]] = []
    end
    @game_teams_data.each do |row|
      if row[:hoa] == "home"
        teams[row[:team_id]] << row[:goals].to_i
      end
    end
    team_average_goals = Hash.new()
    teams.each do |team, goals|
      team_average_goals[team] = (goals.sum.to_f / goals.length).round(2)
    end
    highest_score_home_team = team_average_goals.key(team_average_goals.values.max)
    find_team_name_by_id(highest_score_home_team)
  end

  def lowest_scoring_visitor
    teams = Hash.new()
    @game_teams_data.each do |row|
      teams[row[:team_id]] = []
    end
    @game_teams_data.each do |row|
      if row[:hoa] == "away"
        teams[row[:team_id]] << row[:goals].to_i
      end
    end
    team_average_goals = Hash.new()
    teams.each do |team, goals|
      team_average_goals[team] = (goals.sum.to_f / goals.length).round(2)
    end
    lowest_score_visitor = team_average_goals.key(team_average_goals.values.min)
    find_team_name_by_id(lowest_score_visitor)
  end

  def lowest_scoring_home_team
    teams = Hash.new()
    @game_teams_data.each do |row|
      teams[row[:team_id]] = []
    end
    @game_teams_data.each do |row|
      if row[:hoa] == "home"
        teams[row[:team_id]] << row[:goals].to_i
      end
    end
    team_average_goals = Hash.new()
    teams.each do |team, goals|
      team_average_goals[team] = (goals.sum.to_f / goals.length).round(2)
    end
    lowest_score_home_team = team_average_goals.key(team_average_goals.values.min)
    find_team_name_by_id(lowest_score_home_team)
  end
  
  # Season Statistics
  
  def winningest_coach
    coach_records = {}
    all_coaches_array.each do |coach|
      coach_records[coach] = {wins: 0, total_games: 0}
    end
    @game_teams_data.each do |row|
      result = row[:result]
      coach = row[:head_coach].to_sym
      if result == "WIN"
        coach_records[coach][:wins] += 1
        coach_records[coach][:total_games] += 1
      else
        coach_records[coach][:total_games] += 1
      end
    end
    new_hash = coach_records.map do |coach, record|
      [coach, (record[:wins].to_f/record[:total_games].to_f)]
    end.to_h
    (new_hash.key(new_hash.values.max)).to_s
  end
    
  def worst_coach
    coach_records = {}
    all_coaches_array.each do |coach|
      coach_records[coach] = {wins: 0, total_games: 0}
    end
    @game_teams_data.each do |row|
      result = row[:result]
      coach = row[:head_coach].to_sym
      if result == "WIN"
        coach_records[coach][:wins] += 1
        coach_records[coach][:total_games] += 1
      else
        coach_records[coach][:total_games] += 1
      end
    end
    new_hash = coach_records.map do |coach, record|
      [coach, (record[:wins].to_f/record[:total_games].to_f)]
    end.to_h
    (new_hash.key(new_hash.values.min)).to_s
  end

  def most_accurate_team
    accuracy_by_id = Hash.new(0)
    @game_teams_data.each do |row|
      goals = row[:goals].to_f
      shots = row[:shots].to_f
      team_id = row[:team_id]
      accuracy = goals / shots
      accuracy_by_id[team_id] = accuracy
    end
    accurate_id = accuracy_by_id.key(accuracy_by_id.values.max)
    find_team_name_by_id(accurate_id)
  end

  def least_accurate_team
    accuracy_by_id = Hash.new
    @game_teams_data.each do |row|
      goals = row[:goals].to_f
      shots = row[:shots].to_f
      team_id = row[:team_id]
      accuracy = goals / shots
      accuracy_by_id[team_id] = accuracy
    end
    accurate_id = accuracy_by_id.key(accuracy_by_id.values.min)
    find_team_name_by_id(accurate_id)
  end

  def most_tackles
    tackles_by_id = Hash.new
    @game_teams_data.each do |row|
      tackles_by_id[row[:team_id]] = row[:tackles]
    end
    most_tackle_id = tackles_by_id.key(tackles_by_id.values.max)
    find_team_name_by_id(most_tackle_id)
  end

  def fewest_tackles
    tackles_by_id = Hash.new
    @game_teams_data.each do |row|
      tackles_by_id[row[:team_id]] = row[:tackles]
    end
    least_tackle_id = tackles_by_id.key(tackles_by_id.values.min)
    find_team_name_by_id(least_tackle_id)
  end

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

  def best_season


  end

  def worst_season

  end

  def average_win_percentage(given_team_id)
    all_team_games = find_all_team_games(given_team_id)




  end

  def most_goals_scored

  end

  def fewest_goals_scored

  end

  def favorite_opponent(given_team_id)
    #hash that has for a key every other team in league
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
    require 'pry'; binding.pry
    find_team_name_by_id(rival_team_id)
  end


  def rival(given_team_id)
    #hash that has for a key every other team in league
    all_away_games = @games_data.find_all do |team|
      team[:away_team_id] == given_team_id.to_s
    end
    all_home_games = @games_data.find_all do |team|
      team[:home_team_id] == given_team_id.to_s
    end

    all_team_games = all_home_games + all_away_games

    team_opponent_hash = Hash.new{|h,k| h[k] = [0.0, 0.0]}
      all_team_games.each do |game|
      #home games
      if game[:away_team_id] != given_team_id
        if game[:away_goals] > game[:home_goals]
          team_opponent_hash[game[:away_team_id]][1] += 1
        elsif game[:away_goals] < game[:home_goals]
          team_opponent_hash[game[:away_team_id]][0] += 1
          #ties are counted as 0.5's or 0's
        # else
        #   team_opponent_hash[game[:away_team_id]][1] += 1
        #   team_opponent_hash[game[:away_team_id]][0] += 0.5
        end
        #away games
      elsif game[:home_team_id] != given_team_id
          if game[:home_goals] > game[:away_goals]
            team_opponent_hash[game[:home_team_id]][1] += 1
          elsif game[:home_goals] < game[:away_goals]
            team_opponent_hash[game[:home_team_id]][0] += 1
          end
      end
    end
    #values are an array that has total games won and the total games played against
    team_opponent_hash.delete(given_team_id.to_s)
    rival_array = team_opponent_hash.min_by { |team, array| (array[0] - array [1])}
    rival_team_id = rival_array[0]
    #convert team id to name
    p find_team_name_by_id(rival_team_id)
  end
  # Helper Methods Below

  def find_all_team_games(given_team_id)
    all_away_games = @games_data.find_all do |team|
      team[:away_team_id] == given_team_id.to_s
    end
    all_home_games = @games_data.find_all do |team|
      team[:home_team_id] == given_team_id.to_s
    end
    all_team_games = all_home_games + all_away_games
  end


  def find_team_name_by_id(id_number)
    team_name = nil
    @teams_data.each do |row|
      team_name = row[:teamname] if row[:team_id] == id_number.to_s
    end
    team_name
  end

  def all_coaches_array
    coach_array = []
    @game_teams_data.each do |row|
      coach_array << row[:head_coach]
    end
    coach_array.uniq!.map do |coach|
      coach.to_sym
    end
  end
end

