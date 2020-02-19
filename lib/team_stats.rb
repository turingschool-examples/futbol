class TeamStats

# team_info(team_id)
  # @@team[team_id]

# best_season & worst_season
  # the first 4 characters of game_id indicate the season
    # @@game_teams.game_id.to_s.slice(0..3)
  # if team_id
    # season_hash[4-game_id] = (+wins / +total_games).max_by
    # season_hash[4-game_id] = (+losses / +total_games).min_by
    # 4-game_id + (4-game.id.to_i + 1).to_s

  # average_win_percentage
    # @@game_teams[:team_id] += total_games
    # (@@game_teams[:team_id] += WINs) / total_games

  # most_goals_scored & fewest_goals
    # if @@game_teams[:team_id] << goals_array
    # goals_array.sort.first
    # goals_array.sort.last

  # favorite_opponent
    #
end
