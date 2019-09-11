module Teamable

  def team_info(team_id)
   {
      "team_id"      => teams[team_id].id,
      "team_name"    => teams[team_id].name,
      "franchise_id" => teams[team_id].franchise_id,
      "abbreviation" => teams[team_id].abbreviation,
      "link"         => teams[team_id].link
    }
  end

  def best_season(team_id)
    seasons
      .values
      .max_by {|season| season.teams[team_id].total_wins / season.teams[team_id].games.length.to_f}
      .id
  end

  def worst_season(team_id)
    seasons
      .values
      .min_by {|season| season.teams[team_id].total_wins / season.teams[team_id].games.length.to_f}
      .id
  end

  def average_win_percentage(team_id)
    (teams[team_id].total_wins / teams[team_id].games.length.to_f).round(2)
  end

  def most_goals_scored(team_id)
    game = teams[team_id].games.values.max_by {|game| teams[team_id].goals_scored(game)}
    teams[team_id].goals_scored(game)
  end

  def fewest_goals_scored(team_id)
    game = teams[team_id].games.values.min_by {|game| teams[team_id].goals_scored(game)}
    teams[team_id].goals_scored(game)
  end

  def favorite_opponent(team_id)
    opponent_hash = teams[team_id].opponent_win_percentage
    favorite_opponent_id = opponent_hash.max_by do |team_id, games_played|
      games_played[:games_won] / games_played[:games_played].to_f
    end
    teams[favorite_opponent_id.first].name
  end

  def rival(team_id)
    opponent_hash = teams[team_id].opponent_win_percentage
    favorite_opponent_id = opponent_hash.min_by do |team_id, games_played|
      games_played[:games_won] / games_played[:games_played].to_f
    end
    teams[favorite_opponent_id.first].name
  end

  def biggest_team_blowout(team_id)
    blowout_game = teams[team_id].games.values.max_by do |game|
      teams[team_id].win?(game) ? game.goals_difference.abs : 0
    end
    blowout_game.goals_difference.abs
  end

  def worst_loss(team_id)
    loss_game = teams[team_id].games.values.max_by do |game|
      !teams[team_id].win?(game) ? game.goals_difference.abs : 0
    end
    loss_game.goals_difference.abs
  end

  def head_to_head(team_id)
    opponent_hash = teams[team_id].opponent_win_percentage
    return_hash = {}
    opponent_hash.each do |id, data|
      return_hash[teams[id].name] = (data[:games_won] / data[:games_played].to_f).round(2)
    end
    return_hash
  end

  def seasonal_summary(team_id)
    return_hash = {}

    seasons.each do |season_id, season|
      team = season.teams[team_id]
      regular_season_hash = {
        win_percentage:        0,
        total_goals_scored:    0,
        total_goals_against:   0,
        average_goals_scored:  0,
        average_goals_against: 0
      }
      postseason_hash = {
        win_percentage:        0,
        total_goals_scored:    0,
        total_goals_against:   0,
        average_goals_scored:  0,
        average_goals_against: 0
      }
      num_regular_games    = 0
      num_postseason_games = 0

      team.games.values.each do |game|
        if game.type == "Regular Season"
          regular_season_hash[:win_percentage]        += 1 if team.win?(game)
          regular_season_hash[:total_goals_scored]    += team.goals_scored(game)
          regular_season_hash[:total_goals_against]   += team.goals_allowed(game)
          regular_season_hash[:average_goals_scored]  += team.goals_scored(game)
          regular_season_hash[:average_goals_against] += team.goals_allowed(game)
          num_regular_games += 1
        else
          postseason_hash[:win_percentage]        += 1 if team.win?(game)
          postseason_hash[:total_goals_scored]    += team.goals_scored(game)
          postseason_hash[:total_goals_against]   += team.goals_allowed(game)
          postseason_hash[:average_goals_scored]  += team.goals_scored(game)
          postseason_hash[:average_goals_against] += team.goals_allowed(game)
          num_postseason_games += 1
        end
      end

      regular_season_hash[:win_percentage]        /= num_regular_games == 0 ? 1 : num_regular_games.to_f
      regular_season_hash[:average_goals_scored]  /= num_regular_games == 0 ? 1 : num_regular_games.to_f
      regular_season_hash[:average_goals_against] /= num_regular_games == 0 ? 1 : num_regular_games.to_f

      postseason_hash[:win_percentage]        /= num_postseason_games == 0 ? 1 : num_postseason_games.to_f
      postseason_hash[:average_goals_scored]  /= num_postseason_games == 0 ? 1 : num_postseason_games.to_f
      postseason_hash[:average_goals_against] /= num_postseason_games == 0 ? 1 : num_postseason_games.to_f

      ##############################
      # Can this be done up above? #
      ##############################
      regular_season_hash[:win_percentage]        = regular_season_hash[:win_percentage].round(2)
      regular_season_hash[:average_goals_scored]  = regular_season_hash[:average_goals_scored].round(2)
      regular_season_hash[:average_goals_against] = regular_season_hash[:average_goals_against].round(2)
      postseason_hash[:win_percentage]            = postseason_hash[:win_percentage].round(2)
      postseason_hash[:average_goals_scored]      = postseason_hash[:average_goals_scored].round(2)
      postseason_hash[:average_goals_against]     = postseason_hash[:average_goals_against].round(2)

      return_hash[season_id] = {
        regular_season: regular_season_hash,
        postseason: postseason_hash
      }
    end
    return_hash
  end
end
