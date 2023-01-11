require './lib/modules'

class LeagueStats
include Sortable

  attr_reader :teams, :game_teams

  def initialize(games, game_teams, teams)
    @games = games
    @game_teams = game_teams
    @teams = teams
  end

  def count_of_teams
		@teams.count do |team|
			team.info[:team_name]
		end
	end

  def best_offense
    max_team_goals = goals_per_game_by_team.values.max
		team_id = goals_per_game_by_team.key(max_team_goals)
    team_name_by_id(team_id)
  end

	def worst_offense
    min_team_goals = goals_per_game_by_team.values.min
		team_id = goals_per_game_by_team.key(min_team_goals)
    team_name_by_id(team_id)
  end

  def highest_scoring_visitor
		away_team_scores = all_goals_by_away_team.values.max
    team_id = all_goals_by_away_team.key(away_team_scores)
    team_name_by_id(team_id)
  end

  def lowest_scoring_visitor
		away_team_scores = all_goals_by_away_team.values.min
    team_id = all_goals_by_away_team.key(away_team_scores)
    team_name_by_id(team_id)
  end

  def highest_scoring_home_team
		home_team_scores = all_goals_by_home_team.values.max
    team_id = all_goals_by_home_team.key(home_team_scores)
    team_name_by_id(team_id)
  end

  def lowest_scoring_home_team
		home_team_scores = all_goals_by_home_team.values.min
    team_id = all_goals_by_home_team.key(home_team_scores)
    team_name_by_id(team_id)
  end

  # Helper methods
  
  def all_goals_by_away_team
		scores_by_away_team = scores_by_team(:away_team_id, :away_goals)
		sum_goals(scores_by_away_team)
	end

  def all_goals_by_home_team
		scores_by_home_team = scores_by_team(:home_team_id, :home_goals)
		sum_goals(scores_by_home_team)
	end

	def scores_by_team(hoa_team_id, hoa_goals)
		scores_by_team = Hash.new {|k, v| k[v] = []}
		@games.each do |game|
			scores_by_team[game.info[hoa_team_id]] << game.info[hoa_goals].to_i
		end
		scores_by_team
	end

	def sum_goals(scores_by_team)
		scores_by_team.each do |team, goals|
      scores_by_team[team] = (goals.sum.to_f / goals.count)
		end
	end

  def goals_per_game_by_team
    team_goals = Hash.new(0)
		games_by_team_id.each do |team_id, list_of_games|
			sum_of_goals = list_of_games.sum { |g| g.info[:goals].to_f}
			team_goals[team_id] = sum_of_goals / list_of_games.count
    end
    team_goals
  end
end