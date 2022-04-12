require './lib/team_stats'
require './lib/game'

module TeamStatistics
  def team_info(team_id)
    teams = TeamStats.create_a_list_of_teams(@teams)
    the_team = teams.find { |team| team.team_id == team_id }
    { 'team_id' => the_team.team_id,
      'franchise_id' => the_team.franchise_id,
      'team_name' => the_team.team_name,
      'abbreviation' => the_team.abbreviation,
      'link' => the_team.link }
  end

  def best_season(team_id)
    games = Game.create_list_of_games(@games)
    seasons = {}
    games.each do |game|
      if game.home_team_id == team_id
        if game.home_goals > game.away_goals
          if seasons[game.season].nil?
            seasons[game.season] = 1
          else
            seasons[game.season] += 1
          end
        end
      elsif game.away_team_id == team_id
        if game.home_goals < game.away_goals
          if seasons[game.season].nil?
            seasons[game.season] = 1
          else
            seasons[game.season] += 1
          end
        end
      end
    end
    seasons.sort_by { |_season, wins| wins }[-1][0]
  end

  def worst_season(team_id)
    games = Game.create_list_of_games(@games)
    seasons = {}
    games.each do |game|
      if game.home_team_id == team_id
        if game.home_goals > game.away_goals
          if seasons[game.season].nil?
            seasons[game.season] = 1
          else
            seasons[game.season] += 1
          end
        end
      elsif game.away_team_id == team_id
        if game.home_goals < game.away_goals
          if seasons[game.season].nil?
            seasons[game.season] = 1
          else
            seasons[game.season] += 1
          end
        end
      end
    end
    seasons.sort_by { |_season, wins| wins }[0][0]
  end
end
