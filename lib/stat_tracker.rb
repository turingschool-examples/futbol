require "csv"
class StatTracker
	attr_accessor :game_teams,
                :games,
                :teams

	def initialize(locations)
    @game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol 
    @games = CSV.read locations[:games], headers: true, header_converters: :symbol
    @teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
	end
  
	def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def total_score
    total_score = games.map do |game|
      game[:home_goals].to_i + game[:away_goals].to_i
    end
  end

  def highest_total_score
    total_score.max
  end

  def lowest_total_score
    total_score.min
  end

	def percentage_home_wins
		home_wins = []
		games.each do |game|
			if game[:home_goals].to_i > game[:away_goals].to_i
				home_wins << game
			end
		end
		(home_wins.count / games.count.to_f).round(2)
	end

	def percentage_visitor_wins
		visitor_wins = []
		games.each do |game|
			if game[:away_goals].to_i > game[:home_goals].to_i
				visitor_wins << game
			end
		end
		(visitor_wins.count / games.count.to_f).round(2)
	end

	def percentage_ties
		ties = []
		games.each do |game|
			if game[:away_goals].to_i == game[:home_goals].to_i
				ties << game
			end
		end
		(ties.count / games.count.to_f).round(2)
	end

  def count_of_games_by_season
    count_of_games_by_season = Hash.new {0}

    games[:season].each do |season|
      count_of_games_by_season[season] += 1
    end
    
    count_of_games_by_season
  end

  def average_goals_per_game
    sums = []
    i = 0
    while i < games.count
      sums << games[:away_goals][i].to_f + games[:home_goals][i].to_f
      i += 1
    end
    total_average = (sums.sum/games.count).round(2)
  end

  def average_goals_by_season
    average_goals_by_season = Hash.new {0}
    total_goals_by_season = Hash.new {0}
		
    i = 0
    games[:season].each do |season|
      if total_goals_by_season[season] == nil
        total_goals_by_season[season] = games[:away_goals][i].to_f + games[:home_goals][i].to_f
      else
        total_goals_by_season[season] += games[:away_goals][i].to_f + games[:home_goals][i].to_f
      end
      i += 1
			
    end
    total_goals_by_season.each do |season, total_goals|
      average_goals_by_season[season] = (total_goals/count_of_games_by_season[season]).round(2)
    end

    average_goals_by_season
  end

  def count_of_teams
    total_teams = teams.count
  end

  def best_offense
    teams_total_scores = Hash.new{0}
    teams_total_games = Hash.new{0}
    teams_total_averages = Hash.new{0}
    i = 0
    
    game_teams[:team_id].each do |id|
      if teams_total_scores[id] == nil
        teams_total_scores[id] = game_teams[:goals][i].to_f
        teams_total_games[id] = 1
      else
        teams_total_scores[id] += game_teams[:goals][i].to_f
        teams_total_games[id] += 1
      end
      i += 1
    end
    teams_total_scores.each do |key, value|
      teams_total_averages[key] = (value / teams_total_games[key].to_f).round(5)
    end
    best_offensive_team_id = teams_total_averages.max_by{|k, v| v}[0]

    best_offensive_team_name = teams.find {|row| row[:team_id] == best_offensive_team_id}[:teamname]
  end
end