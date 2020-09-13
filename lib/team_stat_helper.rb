class TeamStatHelper
  def collect_seasons(team_id)
    season_game_id_hash = {}
      @game.each do |game_id, game|
        if  season_game_id_hash[game.season].nil? && (team_id.to_i == game.away_team_id || team_id.to_i == game.home_team_id)
           season_game_id_hash[game.season] = [game]
         elsif (team_id.to_i == game.away_team_id) || (team_id.to_i == game.home_team_id)
           season_game_id_hash[game.season] << game
         end
      end
    season_game_id_hash
  end

  def collect_wins_per_season(team_id)
    season_wins = {}
    collect_seasons(team_id).each do |season, info|
      wins = 0
      info.each do |game|
        if (team_id.to_i) == game.away_team_id && (game.away_goals > game.home_goals)
          wins += 1
        elsif (team_id.to_i) == game.home_team_id && (game.away_goals < game.home_goals)
          wins += 1
        end
      end
      season_wins[season] = wins
    end
    season_wins
  end

  def collect_losses_per_season(team_id)
    season_losses = {}
    collect_seasons(team_id).each do |season, info|
      losses = 0
      info.each do |game|
        if (team_id.to_i) == game.away_team_id && (game.away_goals < game.home_goals || game.away_goals == game.home_goals)
          losses += 1
        elsif (team_id.to_i) == game.home_team_id && (game.away_goals > game.home_goals || game.away_goals == game.home_goals)
          losses += 1
        end
      end
      season_losses[season] = losses
    end
    season_losses
  end

  def games_for_team_id(team_id)
    games = []
      @game.each do |game_id, game_info|
        if game_info.away_team_id == team_id.to_i || game_info.home_team_id == team_id.to_i
          games << game_info.game_id
        end
      end
    @game_team.find_all do |game|
      games.include?(game.game_id)
    end
  end
end
