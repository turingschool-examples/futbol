require_relative './calculateable'
require_relative './gatherable'

module SeasonStats
  include Calculateable
  include Gatherable

  def most_tackles(season_id)
    team_tackles = {}
    @games.collection.each do |game|
      if game.last.season == season_id
        team_tackles[game.last.away_team_id] = game.last.away_tackles.to_i
        team_tackles[game.last.home_team_id] = game.last.home_tackles.to_i
      end
    end

    team_id = team_tackles.max_by { |team| team.last}

    get_team_name_by_id(team_id.first)
  end

  def most_goals_scored
    require 'pry'; binding.pry
  end

end
