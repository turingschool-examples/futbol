require './lib/modules'

class TeamStats
  include Sort

  attr_reader :teams, :games, :game_teams

  def initialize(teams, games, game_teams)
    @teams = teams
    @games = games
		@game_teams = game_teams
  end

  def team_info(team_id)
    team_hash = {
      'team_id' => nil,
      'franchise_id' => nil,
      'team_name' => nil,
      'abbreviation' => nil,
      'stadium' => nil,
      'link' => nil
    }

    find_team_by_id[team_id].each do |team|
      x = 0
      team_hash.each do |info, value|
        team_hash[info] = team.info.values[x]
        x += 1
      end
    end
    team_hash.delete('stadium')
    team_hash
  end

  def most_goals_scored(team_id)
		all_game_scores_by_team[team_id].max
	end
	
	def fewest_goals_scored(team_id)
		all_game_scores_by_team[team_id].min
	end

	def all_game_scores_by_team
		hash = Hash.new {|k, v| k[v] = []}
		@games.each do |game|
			hash[game.info[:home_team_id]] << game.info[:home_goals]
			hash[game.info[:away_team_id]] << game.info[:away_goals]
		end
		hash
	end

	def rival(team_id)
		win_or_loss(team_id, 'WIN')
	end

	def favorite_opponent(team_id)
		win_or_loss(team_id, 'LOSS')
	end

	def win_or_loss(team_id, win_loss_string)
		opponent_games = games_of_opposite_team(team_id)
		opponent_results = opponent_game_results(opponent_games)
		opponent_results.each do |k,v|
			opponent_results[k] = (v.count(win_loss_string).to_f / v.count).round(2)
		end
		team_id = opponent_results.key(opponent_results.values.max)
		team_name_by_id(team_id)
	end

	def opponent_game_results(opponent_games)
		opponent_results = Hash.new {|k,v| k[v] = []}
		opponent_games.each do |game_id, game|
			opponent_results[game.info[:team_id]] << game.info[:result]
		end
		opponent_results
	end

	def games_of_opposite_team(team_id)
		all_games_by_team = games_by_team_id[team_id].find_all do |game|
			game.info[:team_id] == team_id
		end
		opponent_games = {}
		all_games_by_team.each do |game|
			game = games_by_game_id[game.info[:game_id]].find {|element| element.info[:team_id] != team_id}
			opponent_games[game.info[:game_id]] = game
		end
		opponent_games
	end
end