require './lib/modules'

class LeagueStats
include Sort

  attr_reader :teams, :game_teams
  def initialize(game_teams, teams, games)
    @game_teams = game_teams
    @teams = teams
    @games = games
  end

  def count_of_teams
		@teams.count do |team|
			team.info[:team_name]
		end
	end

  def best_offense
    goals_per_game_by_team
		team_id = goals_per_game_by_team.key(goals_per_game_by_team.values.max)
    team_name_by_id(team_id)
  end

	def worst_offense
    goals_per_game_by_team
		team_id = goals_per_game_by_team.key(goals_per_game_by_team.values.min)
    team_name_by_id(team_id)
  end

  def highest_scoring_visitor
    team_id = all_game_scores_by_away_team.key(all_game_scores_by_away_team.values.max)
    team_name_by_id(team_id)
  end

  def lowest_scoring_visitor
    team_id = all_game_scores_by_away_team.key(all_game_scores_by_away_team.values.min)
    team_name_by_id(team_id)
  end

  def highest_scoring_home_team
    team_id = all_game_scores_by_home_team.key(all_game_scores_by_home_team.values.max)
    team_name_by_id(team_id)
  end

  def lowest_scoring_home_team
    team_id = all_game_scores_by_home_team.key(all_game_scores_by_home_team.values.min)
    team_name_by_id(team_id)
  end

  ### HELPERS
  
  def all_game_scores_by_away_team
		hash = Hash.new {|k, v| k[v] = []}
		@games.each do |game|
			hash[game.info[:away_team_id]] << game.info[:away_goals].to_i
		end
		hash.each do |team, goals|
      hash[team] = (goals.sum.to_f / goals.count).round(2)
		end
	end

  def all_game_scores_by_home_team
		hash = Hash.new {|k, v| k[v] = []}
		@games.each do |game|
			hash[game.info[:home_team_id]] << game.info[:home_goals].to_i
		end
		hash.each do |team, goals|
      hash[team] = (goals.sum.to_f / goals.count).round(2)
		end
	end

  def goals_per_game_by_team
    hash = Hash.new(0)
		games_by_team_id.each do |team_id, array_of_games|
			hash[team_id] = (array_of_games.sum { |g| g.info[:goals].to_f})/array_of_games.count
    end
    hash
  end
end