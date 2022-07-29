require 'csv'

class StatTracker

  def initialize(locations)
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
    records = coach_records(season)
    games_by_season(season).each do |game|
      @game_teams_data.each do |row|
        process_record(records, row) if game == row[:game_id]
      end
    end
    winning_record(records).max_by { |h,k| k }[0].to_s
  end

  def worst_coach(season)
    records = coach_records(season)
    games_by_season(season).each do |game|
      @game_teams_data.each do |row|
        process_record(records, row) if game == row[:game_id]
      end
    end
    winning_record(records).min_by { |h,k| k }[0].to_s
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
    find_team_name_by_id(rival_team_id)
  end


  def rival(given_team_id)
    
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
    fav_opponent_array = wins_and_losses.min_by { |team, array| (array[0] - array [1])}
    rival_team_id = fav_opponent_array[0]
    #convert team id to name
    require 'pry'; binding.pry
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

  def coach_records(season)
    coach_records = Hash.new
    coaches_by_season(season).each do |coach|
      coach_records.store(coach, {wins: 0, total_games: 0})
    end
    coach_records
  end

  def process_record(records, row)
    if row[:result] == "WIN"
      records[row[:head_coach].to_sym][:wins] += 1
      records[row[:head_coach].to_sym][:total_games] += 1
    else
      records[row[:head_coach].to_sym][:total_games] += 1
    end
  end

  def winning_record(records)
    records.map do |coach, record|
      [coach, (record[:wins].to_f/record[:total_games].to_f)]
    end.to_h
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

