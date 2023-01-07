require './lib/modules'

class TeamStats
  include Sort

  attr_reader :teams, :games

  def initialize(teams, games)
    @teams = teams
    @games = games
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
end