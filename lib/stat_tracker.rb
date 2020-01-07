require_relative "./league"
require_relative './modules/team_searchable'
require_relative './modules/game_searchable'
require_relative './modules/season_searchable'

class StatTracker < League
  include TeamSearchable
  include GameSearchable
  include SeasonSearchable

	def count_of_games_by_season
		games_by_season = {}
		@seasons.each {|season| games_by_season[season.id.to_s] = season.total_games}
		games_by_season
	end


	def average_goals_by_season
		@seasons.reduce({}) do |acc, season|
			acc[season.id.to_s] = (season.games_unsorted.sum {|game| game.total_score}/season.games_unsorted.length.to_f).round(2)
			acc
		end
  end

  def game_stat_check
    Game.all.find_all {|game| game.stats.keys[1].to_i != game.home_team_id}
  end
end
