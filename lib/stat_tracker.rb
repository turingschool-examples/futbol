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
		# look for helper methods during refactor
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

	def team_away_goals_by_id
		goals = Hash.new { | k, v | k[v]= [] } 
		games.each do |game|
			goals[game[:away_team_id]] << game[:away_goals].to_i			
		end
		scores_by_team_name = Hash.new { | k, v | k[v]= [] } 
		goals.each do |team_id, score|
			teams.each do |team|
				if team_id == team[:team_id]
					scores_by_team_name[team[:teamname]] = score					
				end
			end
		end
		scores_by_team_name
	end
	
	def team_home_goals_by_id
		goals = Hash.new { | k, v | k[v]= [] } 
		games.each do |game|
			goals[game[:home_team_id]] << game[:home_goals].to_i
		end
		scores_by_team_name = Hash.new { | k, v | k[v]= [] } 
		goals.each do |team_id, score|
			teams.each do |team|
				if team_id == team[:team_id]
					scores_by_team_name[team[:teamname]] = score					
				end
			end
		end
		scores_by_team_name		
	end	

	def average_score_away_game
		averages_by_teamname = Hash.new { | k, v | k[v]= [] }
		team_away_goals_by_id.each do | k, v |
			value = v.sum.to_f / v.count.to_f
			averages_by_teamname[k] = value
		end
		averages_by_teamname
	end
	
	def average_score_home_game
		averages_by_teamname = Hash.new { | k, v | k[v]= [] }
		team_home_goals_by_id.each do | k, v |
			value = v.sum.to_f / v.count.to_f
			averages_by_teamname[k] = value
		end
		averages_by_teamname
	end

	def highest_scoring_visitor
		max = average_score_away_game.max_by { |teamname, average_score| average_score}
		max[0]
	end

	def highest_scoring_home_team
		max = average_score_home_game.max_by { |teamname, average_score| average_score}
		max[0]
	end
end