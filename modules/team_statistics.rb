require './lib/team_stats'
require './lib/game'
require './lib/game_teams'

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
    seasons = count_season_wins(games, team_id)
    seasons.sort_by { |_season, wins| wins }[-1][0]
  end

  def worst_season(team_id)
    games = Game.create_list_of_games(@games)
    seasons = count_season_wins(games, team_id)
    seasons.sort_by { |_season, wins| wins }[0][0]
  end

  def average_win_percentage(team_id)
    games = Game.create_list_of_games(@games)
    total_games = games.count { |game| game.home_team_id == team_id || game.away_team_id == team_id }
    seasons = count_season_wins(games, team_id)
    total_games_per_season = games.count do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end / seasons.length
    percentage = seasons.map { |_season, wins| wins.to_f / total_games_per_season }.sum / seasons.length
    percentage.round(2)
  end

  def count_season_wins(games, team_id)
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
    seasons
  end

  def most_goals_scored(team_id)
    games = GameTeams.create_list_of_game_teams(@game_teams)
    teams_games = games.find_all { |game| game.team_id == team_id }
    teams_games.sort_by { |game| game.goals }[-1].goals
  end

  def fewest_goals_scored(team_id)
    games = GameTeams.create_list_of_game_teams(@game_teams)
    teams_games = games.find_all { |game| game.team_id == team_id }
    teams_games.sort_by { |game| game.goals }[0].goals
  end
end
