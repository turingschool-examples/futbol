require './spec/spec_helper'

class StatTracker
  attr_reader :all_data, :games, :game_teams, :teams, :game_ids
  
  def initialize(all_data)
    @all_data = all_data
    @games = []
    @game_teams = []
    @teams = []
    @game_ids = []
    create_games
    create_game_teams
    game_ids
    create_teams
  end

  def self.from_csv(locations)
    all_data = {}
    locations.each do |file_name, location|
      formatted_csv = CSV.open location, headers: true, header_converters: :symbol
      all_data[file_name] = formatted_csv
    end
    StatTracker.new(all_data)
  end

  ## Returns highest total score of added scores of that game (INTEGER)
  def highest_total_score
    games_hash.values.max
  end

  ## Returns lowest total score of added scores of that game (INTEGER)
  def lowest_total_score
    games_hash.values.min
  end

  ## A hash with season names (e.g. 20122013) as keys and counts of games as values
  def count_of_games_by_season
  count_games = {}
   @games.each do |game|
    if count_games[game.season].nil? # Added [1] to continue method with adjustment to games_list
      count_games[game.season] = 1
    else
      count_games[game.season] +=1
    end
   end
   count_games
  end

  def percentage_home_wins
    number_of_games = game_ids.length
    games_won = 0
    @game_teams.each do |game|
      if game.hoa == 'home' && game.result == 'WIN'
        games_won += 1
      end
    end
    percentage = (games_won.to_f / number_of_games.to_f).round(2)
  end
  
  def percentage_visitor_wins
    number_of_games = game_ids.length
    games_won = 0
    @game_teams.each do |game|
      if game.hoa == 'away' && game.result == 'WIN'
        games_won += 1
      end
    end
    percentage = (games_won.to_f / number_of_games.to_f).round(2)
  end

  def percentage_ties   
    number_of_games = game_ids.length
    games_tied = 0
    @game_teams.each do |game|
      if game.hoa == 'away' && game.result == 'TIE'
        games_tied += 1
      end
    end
    percentage = (games_tied.to_f / number_of_games.to_f).round(2)
  end
  
  ## LEAGUE SCORING
  
  def lowest_scoring_visitor
    team_goals = Hash.new(0)
    @game_teams.each do |game_team, goals|
      if game_team.hoa == 'away' && !team_goals.include?(game_team.team_id)
        team_goals[game_team.team_id] = [game_team.goals.to_f]
      elsif game_team.hoa == 'away' && team_goals.include?(game_team.team_id)
        team_goals[game_team.team_id] << game_team.goals.to_f
      end
    end
    min_team_name(team_goals)
  end

  def lowest_scoring_home_team
    team_goals = Hash.new(0)
    @game_teams.each do |game_team, goals|
      if game_team.hoa == 'home' && !team_goals.include?(game_team.team_id)
        team_goals[game_team.team_id] = [game_team.goals.to_f]
      elsif game_team.hoa == 'home' && team_goals.include?(game_team.team_id)
        team_goals[game_team.team_id] << game_team.goals.to_f
      end
    end
    min_team_name(team_goals)
  end

  def highest_scoring_home_team
    team_goals = Hash.new(0)
    @game_teams.each do |game_team, goals|
      if game_team.hoa == 'home' && !team_goals.include?(game_team.team_id)
        team_goals[game_team.team_id] = [game_team.goals.to_f]
      elsif game_team.hoa == 'home' && team_goals.include?(game_team.team_id)
        team_goals[game_team.team_id] << game_team.goals.to_f
      end
    end
    max(team_goals)
  end


  def highest_scoring_visitor
    team_goals = Hash.new(0)
    @game_teams.each do |game_team, goals|
      if game_team.hoa == 'away' && !team_goals.include?(game_team.team_id)
        team_goals[game_team.team_id] = [game_team.goals.to_f]
      elsif game_team.hoa == 'away' && team_goals.include?(game_team.team_id)
        team_goals[game_team.team_id] << game_team.goals.to_f
      end
    end
    max(team_goals)
  end
  
  def winningest_coach
  "Name of the Coach with the 
  best win percentage for the season"
  # create a unique list of head_coachs
  # add a count + 1 each time that coach wins 
  # find the coach with the highest win 
   winning_games = @game_teams.find_all{|game_team| game_team.result == "WIN"}
   coach_count = {}
   winning_games.each do |game|
    if coach_count[game.head_coach].nil? 
      coach_count[game.head_coach] = 1
    else 
      coach_count[game.head_coach] += 1
    end
  end 
  coach_count.max_by{|k,v| v}.first
end

def worst_coach
  "	Name of the Coach with the worst win
   percentage for the season"
  # create a unique list of head_coachs
  # add a count + 1 each time that coach wins 
  # find the coach with the lowest win 
   winning_games = @game_teams.find_all{|game_team| game_team.result == "WIN"}
   coach_count = {}
   winning_games.each do |game|
    if coach_count[game.head_coach].nil? 
      coach_count[game.head_coach] = 1
    else 
      coach_count[game.head_coach] += 1
    end
  end 
  coach_count.min_by{|k,v| v}.first
  binding.pry
end

  ##HELPER METHODS
  ## Creates an array of game_ids, acts as helper method
  def game_ids
    @game_ids = @game_teams.map{|game| game.game_id}.uniq
  end
  
  ## Finds the max average score by game id and returns team name
  def max(team_goals)
    team_averages = {}
    team_goals.each do |team_goal, value|
      team_averages[team_goal] = (value.sum / value.length.to_f)
    end
    max = team_averages.max_by{|k,v| v}
    highest_team = @teams.find { |team| team.team_id == max.first}
    highest_team.team_name
  end

  ## Finds the min average score by game id and returns team name
  def min_team_name(team_goals)
    team_averages = {}
    team_goals.each do |team_goal, value|
      team_averages[team_goal] = (value.sum / value.length.to_f)
    end
    min = team_averages.min_by{|k,v| v}
    lowest_team = @teams.find { |team| team.team_id == min.first}
    lowest_team.team_name
  end

  def count_of_teams
    @teams.count
  end

  def team_games_league_total
    @teams.reduce(Hash.new(0)) do |team_games_total, team|
      @games.each do |game|
        if team.team_id == game.home_team_id || team.team_id == game.away_team_id
          team_games_total[team.team_id] += 1 
        end
      end
      team_games_total
    end
  end
  
  def team_goals_league_total
    @teams.reduce(Hash.new(0)) do |team_goals_total, team|
      @games.each do |game|
        if team.team_id == game.home_team_id
          team_goals_total[team.team_id] += game.home_goals
        elsif team.team_id == game.away_team_id
          team_goals_total[team.team_id] += game.away_goals
        end
      end
      team_goals_total
    end
  end

  def avg_team_goals_league
      team_avgs = Hash.new
      @teams.each do |team|
        team_games = team_games_league_total[team.team_id]
        team_goals = team_goals_league_total[team.team_id]
        goal_stat = (team_goals.to_f / team_games.to_f).round(2)
        team_avgs[team.team_id] = goal_stat
      end
      team_avgs
  end

  def max_avg_team_goals_league
    averages_with_nan = avg_team_goals_league.values
    # gets rid of any values taht are true for nan?
    max_avg = averages_with_nan.reject(&:nan?).max
    max_ids = avg_team_goals_league.select do |team_id, average|
      average == max_avg
    end
  end

  def min_avg_team_goals_league
    averages_with_nan = avg_team_goals_league.values
    min_avg = averages_with_nan.reject(&:nan?).min
    min_ids = avg_team_goals_league.select do |team_id, average|
      average == min_avg
    end
  end

  # Finally the actual methods
  def best_offense
    best_team_ids = max_avg_team_goals_league.keys
    team_names = @teams.reduce([]) do |names, team| 
      best_team_ids.each do |id|
        names << team.team_name if id == team.team_id
      end
      names
    end
    team_names.join(' ')
  end

  def worst_offense
    worst_team_ids = min_avg_team_goals_league.keys
    team_names = @teams.reduce([]) do |names, team| 
      worst_team_ids.each do |id|
        names << team.team_name if id == team.team_id
      end
      names
    end
    team_names.join(', ')
  end

  ## Returns average goals per game across ALL seasons rounded to nearest 100th (FLOAT)
  def average_goals_per_game
    game_count = game_ids.count.to_f
    average_goals_per_game = games_hash.values.sum.to_f/game_count
    average_goals_per_game.round(2)
  end

  ## Returns average goals per game with season names as keys and a float for average num of goals per game (HASH)
  def average_goals_by_season
    total_scores_by_season
    average_goals_by_season = total_scores_by_season.map { |season, total_scores| [season, (total_scores.to_f/count_of_games_by_season[season].to_f).round(2)]}.to_h
    average_goals_by_season
  end

##HELPER METHODS
    ## Creates an array of game_ids, acts as helper method
    def game_ids
      @game_ids = @game_teams.map{|game| game.game_id}.uniq
    end

    ## Creates game objects from the CSV file

  def create_teams
    @all_data[:teams].each do |row|
      team = Team.new(row[:team_id], row[:teamname])
      @teams << team
    end
    @teams
  end

  def create_games
    @all_data[:games].each do |row|
      game = Game.new(row[:game_id],
                      row[:season],
                      row[:away_goals],
                      row[:home_goals], 
                      row[:away_team_id], 
                      row[:home_team_id] 
                      )
      @games << game
    end
    @games
  end

  def create_game_teams
    @all_data[:game_teams].each do |row|
      game_team = GameTeam.new(row[:game_id],
                      row[:team_id],
                      row[:goals], 
                      row[:hoa], 
                      row[:result],
                      row[:head_coach]
                      )
      @game_teams << game_team
    end
    @game_teams
  end

  ##Returns a hash of game ID for key and total goals as value
  def games_hash
    games_hash = {}
    game_ids.each do |game_id|
      games_hash[game_id]=0
    end
    @game_teams.each do |game|
      games_hash[game.game_id]+=game.goals.to_i
    end
    games_hash
  end

  ##Returns a hash of season as key and total scores of all games in that season for value
  def total_scores_by_season
    total_scores_by_season = {}
    @games.each do |game|
      if total_scores_by_season[game.season].nil? # Added [1] to continue method with adjustment to games_list
        total_scores_by_season[game.season] = 0
      end
      total_scores_by_season[game.season] += (game.away_goals+game.home_goals)
    end
    total_scores_by_season
  end
end