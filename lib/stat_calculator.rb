class StatCalculator
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

    def inspect
    "#<StatCalculator: games_count=#{@games.count}, teams_count=#{@teams.count}, game_teams_count=#{@game_teams.count}>"
  end

  def average_goals_per_game
    away_goals = 0
    home_goals = 0
    total_games = 0

    @games.each do |game|
      away_goals += game.away_goals
      home_goals += game.home_goals
      total_games += 1
    end

    total_goals = away_goals + home_goals

    average_goals = total_goals.to_f/total_games.to_f  #when dividing both need to be a float in order to work
    average_goals.round(2)
  end

  def average_goals_by_season
    season_goals = {}
  
    @games.each do |game|
      season = game.season
      
      season_goals[season] ||= {total_goals: 0, number_games: 0}

      season_goals[season][:total_goals] += game.away_goals + game.home_goals
      season_goals[season][:number_games] += 1
    end

    average_goals_season = {}

    season_goals.each do |season, info|
      average_goals_season[season] = (info[:total_goals].to_f/info[:number_games]).round(2)
    end

    average_goals_season
  end

  def highest_total_score	
    total = 0
    @games.each do |game|
      total_score = game.away_goals.to_i + game.home_goals.to_i
      if total_score > total 
        total = total_score
      end
    end
    total
  end

  def lowest_total_score
    total = 0
    @games.each do |game|
        total_score = game.away_goals.to_i + game.home_goals.to_i
        if total_score < total
            total = total_score
        end
    end
    total
  end

  def count_of_teams
    @teams.count
  end

  # Calculates the percentage of games that satisfy a given condition
def calculate_percentage(condition)
  total_games = @games.size # Dynamically get total games
  return 0.0 if total_games.zero? # Avoid division by zero

  # Dynamically count games matching the condition
  wins = @games.count { |game| condition.call(game) }
  (wins.to_f / total_games * 100).round(2) # Dynamically calculate percentage
end

# Dynamically calculates the percentage of games won by the home team
def percentage_home_wins
  calculate_percentage(->(game) { game.home_goals.to_i > game.away_goals.to_i })
end

# Dynamically calculates the percentage of games won by the visiting team
def percentage_visitor_wins
  calculate_percentage(->(game) { game.away_goals.to_i > game.home_goals.to_i })
end

# Dynamically calculates the percentage of games that resulted in a tie
def percentage_ties
  calculate_percentage(->(game) { game.home_goals.to_i == game.away_goals.to_i })
end

  # Calculate Coach Performance

def winningest_coach(season_id)
  # Map game_id to season from @games
  game_seasons = @games.each_with_object({}) do |game, hash|
    hash[game.game_id] = game.season
  end

  coach_stats = Hash.new { |hash, key| hash[key] = { wins: 0, games: 0 } }

  # Iterate over game_teams and filter by season using game_seasons
  @game_teams.each do |game_team|
    next unless game_seasons[game_team.game_id] == season_id

    coach = game_team.head_coach
    coach_stats[coach][:games] += 1
    coach_stats[coach][:wins] += 1 if game_team.result == "WIN"
  end

  # Calculate win percentage for each coach and return the coach with the highest percentage
  highest_win_coach = coach_stats.max_by do |_, stats|
    stats[:wins].to_f / stats[:games]
  end

  highest_win_coach&.first # Return the coach name or nil if no data
end

def worst_coach(season_id)
  # Map game_id to season from @games
  game_seasons = @games.each_with_object({}) do |game, hash|
    hash[game.game_id] = game.season
  end

  coach_stats = Hash.new { |hash, key| hash[key] = { wins: 0, games: 0 } }

  # Iterate over game_teams and filter by season using game_seasons
  @game_teams.each do |game_team|
    next unless game_seasons[game_team.game_id] == season_id

    coach = game_team.head_coach
    coach_stats[coach][:games] += 1
    coach_stats[coach][:wins] += 1 if game_team.result == "WIN"
  end

  # Calculate win percentage for each coach and return the coach with the lowest percentage
  lowest_win_coach = coach_stats.min_by do |_, stats|
    stats[:wins].to_f / stats[:games]
  end

  lowest_win_coach&.first # Return the coach name or nil if no data
end

  def lowest_scoring_visitor
    all_scores = Hash.new { |hash, key| hash[key] = [] }

    @games.each do |game|
      all_scores[game.away_team_id] << game.away_goals
    end
    
    #transform_values allows you to create a new hash using the same keys
    #useful for when you want to do math on values without altering the hash structure
    all_average_scores = all_scores.transform_values do |scores|
      (scores.sum.to_f / scores.size).round(3)
    end
    
    lowest_score = all_average_scores.min_by do |team_id, score|
      score
    end
    
    lowest_team_id = lowest_score[0].to_i
    
    team = @teams.find do |team|
      team.team_id == lowest_team_id
    end

    team.team_name
  end

  def highest_scoring_visitor
    all_scores = Hash.new { |hash, key| hash[key] = [] }

    @games.each do |game|
      all_scores[game.away_team_id] << game.away_goals
    end
    
    all_average_scores = all_scores.transform_values do |scores|
      (scores.sum.to_f / scores.size).round(3)
    end
    
    highest_score = all_average_scores.max_by do |team_id, score|
      score
    end
    
    highest_team_id = highest_score[0].to_i
    
    team = @teams.find do |team|
      team.team_id == highest_team_id
    end

    team.team_name
  end
  
  def count_of_games_by_season
    season_games = {}
    @games.each do |game|
      season_name = game.season
      if season_games[game.season].nil?
        season_games[game.season] = 1
      else
        season_games[game.season] += 1
      end
    end
    season_games
  end

  def highest_scoring_home_team
    all_scores = Hash.new { |hash, key| hash[key] = [] }

    @games.each do |game|
      all_scores[game.home_team_id] << game.home_goals
    end
    
    all_average_scores = all_scores.transform_values do |scores|
      (scores.sum.to_f / scores.size).round(3)
    end
    
    highest_score = all_average_scores.max_by do |team_id, score|
      score
    end
    
    highest_team_id = highest_score[0].to_i
    
    team = @teams.find do |team|
      team.team_id == highest_team_id
    end

    team.team_name
  end

  def lowest_scoring_home_team
    all_scores = Hash.new { |hash, key| hash[key] = [] }

    @games.each do |game|
      all_scores[game.home_team_id] << game.home_goals
    end
    
    all_average_scores = all_scores.transform_values do |scores|
      (scores.sum.to_f / scores.size).round(3)
    end
    
    lowest_score = all_average_scores.min_by do |team_id, score|
      score
    end
    
    lowest_team_id = lowest_score[0].to_i
    
    team = @teams.find do |team|
      team.team_id == lowest_team_id
    end

    team.team_name
  end

  def best_offense
    team_goals_games = Hash.new{ |hash, key| hash[key] = {goals: 0, games: 0}}

    @game_teams.each do |game_team|
      team_id = game_team.team_id
      team_goals_games[team_id][:goals] += game_team.goals
      team_goals_games[team_id][:games] += 1
    end

    best_offense_team = team_goals_games.max_by do |team_id, info|
      info[:goals].to_f/info[:games].to_f
    end[0]
    # [0] ensures only the team_id is being pulled
    
    best_offense = @teams.find { |team| team.team_id.to_s == best_offense_team.to_s}
    best_offense.team_name
  end

  def worst_offense
    team_goals_games = Hash.new{ |hash, key| hash[key] = {goals: 0, games: 0}}

    @game_teams.each do |game_team|
      team_id = game_team.team_id
      team_goals_games[team_id][:goals] += game_team.goals
      team_goals_games[team_id][:games] += 1
    end

    worst_offense_team = team_goals_games.min_by do |team_id, info|
      info[:goals].to_f/info[:games].to_f
    end[0]
    # [0] ensures only the team_id is being pulled
    
    worst_offense = @teams.find { |team| team.team_id.to_s == worst_offense_team.to_s}
    worst_offense.team_name
  end

  def most_tackles(season)
    game_ids_for_season = []
    @games.each do |game|
      if game.season == season
        game_ids_for_season << game.game_id
      end
    end
   
    team_tackles = {}
    @game_teams.each do |game_team|
      if game_ids_for_season.include?(game_team.game_id)
        team_tackles[game_team.team_id] ||= 0
        team_tackles[game_team.team_id] += game_team.tackles
      end
    end
    
    team_with_most_tackles = nil
    most_tackles = 0
    team_tackles.each do |team_id, tackles|
      if tackles > most_tackles
        most_tackles = tackles
        team_with_most_tackles = team_id
      end
    end
    
    @teams.each do |team|
      if team.team_id.to_s == team_with_most_tackles.to_s
        return team.team_name
      end
    end
  end  

  def fewest_tackles(season)
    game_ids_for_season = []
    @games.each do |game|
      if game.season == season
        game_ids_for_season << game.game_id
      end
    end
   
    team_tackles = {}
    @game_teams.each do |game_team|
      if game_ids_for_season.include?(game_team.game_id)
        team_tackles[game_team.team_id] ||= 0
        team_tackles[game_team.team_id] += game_team.tackles
      end
    end
    
    team_with_least_tackles = nil
    least_tackles = 1000000 #random number I chose, just needed a big enough number
    team_tackles.each do |team_id, tackles|
      if tackles < least_tackles
        least_tackles = tackles
        team_with_least_tackles = team_id
      end
    end
    
    @teams.each do |team|
      if team.team_id.to_s == team_with_least_tackles.to_s
        return team.team_name
      end
    end
  end
end