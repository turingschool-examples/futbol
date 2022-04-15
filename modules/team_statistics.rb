require './lib/team_stats'
require './lib/game'
require './lib/game_teams'

module TeamStatistics
  def team_info(team_id)
    the_team = @teams.find { |team| team.team_id == team_id }
    { 'team_id' => the_team.team_id,
      'franchise_id' => the_team.franchise_id,
      'team_name' => the_team.team_name,
      'abbreviation' => the_team.abbreviation,
      'link' => the_team.link }
  end

  def best_season(team_id)
    seasons = count_season_wins(@games, team_id)
    seasons.sort_by { |_season, wins| wins }[-1][0]
  end

  def worst_season(team_id)
    seasons = count_season_wins(@games, team_id)
    seasons.sort_by { |_season, wins| wins }[0][0]
  end

  def average_win_percentage(team_id)
    total_games = @games.count { |game| game.home_team_id == team_id || game.away_team_id == team_id }
    seasons = count_season_wins(@games, team_id)
    total_games_per_season = @games.count do |game|
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
    teams_games = @game_teams.find_all { |game| game.team_id == team_id }
    teams_games.sort_by { |game| game.goals }[-1].goals
  end

  def fewest_goals_scored(team_id)
    teams_games = @game_teams.find_all { |game| game.team_id == team_id }
    teams_games.sort_by { |game| game.goals }[0].goals
  end

  def favorite_opponent(team_id)
    wins = count_wins_against_opponent(@games, team_id)
    losses = count_losses_against_opponent(@games, team_id)
    percentages = []
    wins.each do |team, win|
      percentages << if losses[team].nil?
                       [team, win]
                     else
                       [team, win / losses[team]]
                     end
    end
    favorite_team_id = percentages.sort_by { |team| team[1] }[-1][0]
    @teams.find { |team| team.team_id == favorite_team_id }.team_name
  end

  def rival(team_id)
    wins = count_wins_against_opponent(@games, team_id)
    losses = count_losses_against_opponent(@games, team_id)
    percentages = []
    losses.each do |team, loss|
      percentages << if wins[team].nil?
                       [team, loss]
                     else
                       [team, loss / wins[team]]
                     end
    end
    favorite_team_id = percentages.sort_by { |team| team[1] }[-1][0]
    @teams.find { |team| team.team_id == favorite_team_id }.team_name
  end

  def count_wins_against_opponent(games, team_id)
    opponents = {}
    games.each do |game|
      if game.home_team_id == team_id
        if game.home_goals > game.away_goals
          if opponents[game.away_team_id].nil?
            opponents[game.away_team_id] = 1
          else
            opponents[game.away_team_id] += 1
          end
        end
      elsif game.away_team_id == team_id
        if game.home_goals < game.away_goals
          if opponents[game.home_team_id].nil?
            opponents[game.home_team_id] = 1
          else
            opponents[game.home_team_id] += 1
          end
        end
      end
    end
    opponents
  end

  def count_losses_against_opponent(games, team_id)
    opponents = {}
    games.each do |game|
      if game.home_team_id == team_id
        if game.home_goals < game.away_goals
          if opponents[game.away_team_id].nil?
            opponents[game.away_team_id] = 1
          else
            opponents[game.away_team_id] += 1
          end
        end
      elsif game.away_team_id == team_id
        if game.home_goals > game.away_goals
          if opponents[game.home_team_id].nil?
            opponents[game.home_team_id] = 1
          else
            opponents[game.home_team_id] += 1
          end
        end
      end
    end
    opponents
  end
end
