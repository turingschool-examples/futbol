require 'csv'

class StatTracker
  attr_reader :locations,
              :games_data,
              :teams_data,
              :game_teams_data,
              :mock_game_teams_data,
              :mock_games_data

  def initialize(locations)
    @locations = locations
    @games_data = CSV.read(@locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(@locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(@locations[:game_teams], headers: true, header_converters: :symbol)
    @mock_game_teams_data = CSV.read(@locations[:mock_game_teams], headers: true, header_converters: :symbol)
    @mock_games_data = CSV.read(@locations[:mock_games], headers: true, header_converters: :symbol)

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
  
  def winningest_coach(season)
    coach_records = {}
    coaches_by_season(season).each do |coach|
      coach_records[coach] = {wins: 0, total_games: 0}
    end
    games_by_season(season).each do |game|
      @game_teams_data.each do |row|
        if game == row[:game_id]
          result = row[:result]
          coach = row[:head_coach].to_sym
          if result == "WIN"
            coach_records[coach][:wins] += 1
            coach_records[coach][:total_games] += 1
          else
            coach_records[coach][:total_games] += 1
          end
        end
      end
    end
    seasons = coach_records.map do |coach, record|
      [coach, (record[:wins].to_f/record[:total_games].to_f)]
    end.to_h
    (seasons.key(seasons.values.max)).to_s
  end
    
  def worst_coach(season)
    coach_records = {}
    coaches_by_season(season).each do |coach|
      coach_records[coach] = {wins: 0, total_games: 0}
    end
    games_by_season(season).each do |game|
      @game_teams_data.each do |row|
        if game == row[:game_id]
          result = row[:result]
          coach = row[:head_coach].to_sym
          if result == "WIN"
            coach_records[coach][:wins] += 1
            coach_records[coach][:total_games] += 1
          else
            coach_records[coach][:total_games] += 1
          end
        end
      end
    end
    seasons = coach_records.map do |coach, record|
      [coach, (record[:wins].to_f/record[:total_games].to_f)]
    end.to_h
    (seasons.key(seasons.values.min)).to_s
  end

  def most_accurate_team(season)
    team_accuracy_record = {}
    teams_by_season(season).each do |team|
      team_accuracy_record[team.to_sym] = {shots: 0, goals: 0}
    end
    @game_teams_data.each do |row|
      games_by_season(season).each do |game|
        if game == row[:game_id]
          goals = row[:goals].to_i
          shots = row[:shots].to_i
          team_id = row[:team_id].to_sym
          team_accuracy_record[team_id][:goals] += goals
          team_accuracy_record[team_id][:shots] += shots
        end
      end
    end
    selected_team = team_accuracy_record.max_by { |team, hash| (hash[:goals].to_f / hash[:shots].to_f) }
    find_team_name_by_id(selected_team[0])
  end

  def least_accurate_team(season)
    team_accuracy_record = {}
    teams_by_season(season).each do |team|
      team_accuracy_record[team.to_sym] = {shots: 0, goals: 0}
    end
    @game_teams_data.each do |row|
      games_by_season(season).each do |game|
        if game == row[:game_id]
          goals = row[:goals].to_i
          shots = row[:shots].to_i
          team_id = row[:team_id].to_sym
          team_accuracy_record[team_id][:goals] += goals
          team_accuracy_record[team_id][:shots] += shots
        end
      end
    end
    selected_team = team_accuracy_record.min_by { |team, hash| (hash[:goals].to_f / hash[:shots].to_f) }
    find_team_name_by_id(selected_team[0])
  end

  def most_tackles(season)
    team_tackles_record = {}
    teams_by_season(season).each do |team|
      team_tackles_record[team.to_sym] = 0
    end
    @game_teams_data.each do |row|
      games_by_season(season).each do |game|
        if game == row[:game_id]
          tackles = row[:tackles].to_i
          team_tackles_record[row[:team_id].to_sym] += tackles
        end
      end
    end
    selected_team = team_tackles_record.max_by { |team, hash| hash }
    find_team_name_by_id(selected_team[0].to_s)
  end

  def fewest_tackles(season)
    team_tackles_record = {}
    teams_by_season(season).each do |team|
      team_tackles_record[team.to_sym] = 0
    end
    @game_teams_data.each do |row|
      games_by_season(season).each do |game|
        if game == row[:game_id]
          tackles = row[:tackles].to_i
          team_tackles_record[row[:team_id].to_sym] += tackles
        end
      end
    end
    selected_team = team_tackles_record.min_by { |team, hash| hash }
    find_team_name_by_id(selected_team[0].to_s)
  end

  # Team Statistics

  def team_info(given_team_id)
      all_team_info = @teams_data.select do |team|
        team[:team_id] == given_team_id
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

  def average_win_percentage

  end

  def most_goals_scored

  end

  def fewest_goals_scored

  end

  def favorite_opponent(given_team_id)
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
    fav_opponent_array = team_opponent_hash.max_by { |team, array| (array[0] - array [1])}
    rival_team_id = fav_opponent_array[0]
    #convert team id to name
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

  def games_by_season(season)
    games_array = []
    @games_data.each do |row|
    games_array <<row[:game_id] if row[:season] == season
    end
    games_array
  end

  def coaches_by_season(season)
    coaches_array = []
    games_by_season(season).each do |game|
      @game_teams_data.each do |row|
        coaches_array << row[:head_coach].to_sym if game == row[:game_id]
      end
    end
    coaches_array.uniq
  end

  def teams_by_season(season)
    teams_array = []
    games_by_season(season).each do |game|
      @game_teams_data.each do |row|
        if game == row[:game_id]
          teams_array << row[:team_id].to_sym
        end
      end
    end
    teams_array.uniq
  end
end

