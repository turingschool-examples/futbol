module TeamableHelper

  # JP
  def season_array_helper
    season_array = []
    # get array of seasons
    self.games.each_value do |game_obj|
      season_array << game_obj.season
    end
    season_array.uniq!.sort!
  end

  # JP
  def season_win_loss_helper(teamid)
    season_win_loss_hash = Hash.new
    season_array = season_array_helper

    season_array.each do |season|
      season_win_loss_hash[season] = {wins:  0,
                                     games:  0}
    end
    # assign wins to team's seasons
    self.games.each_value do |game_obj|
      if teamid == game_obj.home_team_id
        season_win_loss_hash[game_obj.season][:games] +=1
        if game_obj.home_goals > game_obj.away_goals
          season_win_loss_hash[game_obj.season][:wins] +=1
        end
      elsif teamid == game_obj.away_team_id
        season_win_loss_hash[game_obj.season][:games] +=1
        if game_obj.home_goals < game_obj.away_goals
          season_win_loss_hash[game_obj.season][:wins] +=1
        end
      end
    end
    season_win_loss_hash
  end

  # JP
  def season_win_percentage_helper(teamid)
    season_win_loss_hash = season_win_loss_helper(teamid)
    season_win_percentage_hash = Hash.new

    season_win_loss_hash.each do |season, wl_hash|
      season_win_percentage_hash[season] = (wl_hash[:wins] / wl_hash[:games].to_f).round(2)
    end
    season_win_percentage_hash
  end

  #get games for a team_id
  def games_for_team_helper(team_id)
      games_for_team = []

      self.games.each_value do |game|
        if game.away_team_id == team_id || game.home_team_id == team_id
          games_for_team << game
        end
      end
      games_for_team
  end

  def total_wins_count_helper(team_id, loser_team_id = "0")
    #select games team won and delete rest
    if loser_team_id != "0"
      games_for_team_helper(team_id).find_all do |game|
        if (game.away_team_id == loser_team_id) || (game.home_team_id == loser_team_id)
          if (game.away_team_id == team_id) && (game.away_goals > game.home_goals)
            true
          elsif (game.home_team_id == team_id) && (game.home_goals > game.away_goals)
            true
          else
            false
          end
        end
      end.length.to_f
    else #for all teams
      games_for_team_helper(team_id).find_all do |game|
        if (game.away_team_id == team_id) && (game.away_goals > game.home_goals)
          true
        elsif (game.home_team_id == team_id) && (game.home_goals > game.away_goals)
            true
        else
          false
        end
      end.length.to_f
    end

  end

  def total_games_count_helper(team_id, opponent_team_id)
      games_for_team_helper(team_id).find_all do |game|
        (game.away_team_id == opponent_team_id) || (game.home_team_id == opponent_team_id)
      end.length


    # total_games = []
    # games_for_team_helper(team_id).each do |game|
    #   if game.away_team_id == opponent_team_id
    #     total_games << game
    #   elsif game.home_team_id == opponent_team_id
    #     total_games << game
    #   end
    # end
    # total_games.length
  end

end
