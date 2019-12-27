require_relative 'gatherable'

module Calculateable
  include Gatherable

  def team_average_goals(goals_hash)
    average_goals = {}
    goals_hash.each do |team, tot_score|
      average_goals[team] = (tot_score.to_f / games_by_team[team]).round(2)
    end

    average_goals
  end

  def team_total_seasons(team_id)
    @team_season_collection.collection[team_id].size
  end

  def team_season_keys(team_id)
    { team_id => @team_season_collection.collection[team_id].keys }
  end

  def game_goals(team_id, game)
    require 'pry'; binding.pry
    if team_id == game.home_team_id
      game.home_goals
    else
      game.away_goals
    end
  end

  def team_season_total_goals(team_id)
    @team_season_collection.collection[team_id].reduce({}) do |hash, season|
      require 'pry'; binding.pry
      goals = season[1].flatten.map do |game|
        game_goals(team_id, game)
        require 'pry'; binding.pry
      end
      hash = { team_id = season[0] => goals }
      require 'pry'; binding.pry
      hash
    end
  end
end
