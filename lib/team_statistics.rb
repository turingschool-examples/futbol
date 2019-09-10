module TeamStatistics

  def team_info(team_id)
    found_team = @teams.fetch(team_id.to_i)
    {
      "team_id" => found_team.team_id.to_s,
      "franchise_id" => found_team.franchise_id.to_s,
      "team_name" => found_team.team_name,
      "abbreviation" => found_team.abbreviation,
      "link" => found_team.link
    }
  end

  def best_season(team_id)
    team_id = team_id.to_i
    filtered_games = []
    @games.each do |game_id, game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        filtered_games.push(game)
      end
    end

    # MEMOIZATION
    games_by_season = filtered_games.group_by(&:season)

    season_win_avg = Hash.new(0)
    games_by_season.each do |season, games|
      home_wins = games.find_all do |game|
        game.home_team_id == team_id && game.home_goals > game.away_goals
      end

      away_wins = games.find_all do |game|
        game.away_team_id == team_id && game.home_goals < game.away_goals
      end
      season_win_avg[season] = ((home_wins.length.to_f + away_wins.length) / games.length).round(2)
    end
    season_win_avg.key(season_win_avg.values.max_by { |value| value})
  end

  def worst_season(team_id)
    team_id = team_id.to_i
    filtered_games = []
    @games.each do |game_id, game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        filtered_games.push(game)
      end
    end

    games_by_season = filtered_games.group_by do |game|
      game.season
    end

    season_win_avg = Hash.new(0)
    games_by_season.each do |season, games|
      home_wins = games.find_all do |game|
        game.home_team_id == team_id && game.home_goals > game.away_goals
      end

      away_wins = games.find_all do |game|
        game.away_team_id == team_id && game.home_goals < game.away_goals
      end
      season_win_avg[season] = ((home_wins.length.to_f + away_wins.length) / games.length).round(2)
    end
    season_win_avg.key(season_win_avg.values.min_by { |value| value})
  end

  def average_win_percentage(team_id)
    team_id = team_id.to_i

    filtered_games = []
    @games.each do |game_id, game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        filtered_games.push(game)
      end
    end

    wins = filtered_games.find_all do |game|
      (game.away_team_id == team_id && game.home_goals < game.away_goals) ||
      (game.home_team_id == team_id && game.home_goals > game.away_goals)
    end

    (wins.length.to_f / filtered_games.length).round(2)
  end

  def most_goals_scored(team_id)
    team_id = team_id.to_i

    filtered_games = game_teams.find_all do |game_team|
      game_team.team_id == team_id
    end

    filtered_games.max_by do |game|
      game.goals
    end.goals
  end

  def fewest_goals_scored(team_id)
    team_id = team_id.to_i

    filtered_games = game_teams.find_all do |game_team|
      game_team.team_id == team_id
    end

    filtered_games.min_by do |game|
      game.goals
    end.goals
  end

  def favorite_opponent(team_id)
    team_id = team_id.to_i

    filtered_games = []
    @games.each do |game_id, game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        filtered_games.push(game)
      end
    end

    losses = filtered_games.find_all do |game|
      (game.away_team_id == team_id && game.home_goals >= game.away_goals) ||
      (game.home_team_id == team_id && game.home_goals <= game.away_goals)
    end

    group = Hash.new(0)
    losses.each do |game|
      if game.home_team_id == team_id
        group[game.away_team_id] += 1
      elsif game.away_team_id == team_id
        group[game.home_team_id] += 1
      end
    end
    team_id = (group.min_by {|key, value| value})[0]
    @teams[team_id].team_name
  end

  def rival(team_id)
    team_id = team_id.to_i

    filtered_games = []
    @games.each do |game_id, game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        filtered_games.push(game)
      end
    end

    losses = filtered_games.find_all do |game|
      (game.away_team_id == team_id && game.home_goals >= game.away_goals) ||
      (game.home_team_id == team_id && game.home_goals <= game.away_goals)
    end

    group = Hash.new(0)
    losses.each do |game|
      if game.home_team_id == team_id
        group[game.away_team_id] += 1
      elsif game.away_team_id == team_id
        group[game.home_team_id] += 1
      end
    end
    team_id = (group.max_by {|key, value| value})[0]
    @teams[team_id].team_name
  end

  def biggest_team_blowout(team_id)
    team_id = team_id.to_i

    filtered_games = []
    @games.each do |game_id, game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        filtered_games.push(game)
      end
    end

    wins = filtered_games.find_all do |game|
      (game.away_team_id == team_id && game.home_goals < game.away_goals) ||
      (game.home_team_id == team_id && game.home_goals > game.away_goals)
    end

    biggest_blowout = 0
    wins.each do |win|
      if biggest_blowout < (win.home_goals - win.away_goals).abs
        biggest_blowout = (win.home_goals - win.away_goals).abs
      end
    end
    biggest_blowout.to_i
  end

  def worst_loss(team_id)
    team_id = team_id.to_i

    filtered_games = []
    @games.each do |game_id, game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        filtered_games.push(game)
      end
    end

    losses = filtered_games.find_all do |game|
      (game.away_team_id == team_id && game.home_goals > game.away_goals) ||
      (game.home_team_id == team_id && game.home_goals < game.away_goals)
    end

    worst_loss = 0
    losses.each do |loss|
      if worst_loss < (loss.home_goals - loss.away_goals).abs
        worst_loss = (loss.home_goals - loss.away_goals).abs
      end
    end
    worst_loss.to_i
  end

  def head_to_head(team_id)
    team_id = team_id.to_i

    filtered_games = []
    opponents = Hash.new(0)
    head_averages = Hash.new(0)
    @games.each do |game_id, game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        filtered_games.push(game)
      end
      opponents_home = filtered_games.group_by do |game_o|
        game_o.home_team_id
      end
      opponents_away = filtered_games.group_by do |game_a|
        game_a.away_team_id
      end
      opponents = opponents_home.merge(opponents_away) do |team_id_m, home_value, away_value|
        home_value + away_value
      end
      opponents.each do |opp_team_id, games|
        win_average = games.find_all do |game_f|
          (game_f.away_team_id == team_id && game_f.home_goals < game_f.away_goals) ||
          (game_f.home_team_id == team_id && game_f.home_goals > game_f.away_goals)
        end.length.to_f / games.length
        head_averages[@teams[opp_team_id].team_name] = win_average.round(2)
      end
    end
    head_averages.delete(@teams[team_id].team_name)
    head_averages
  end

  def seasonal_summary(team_id)
    all_seasons = @games.inject([]) do |seasons, (game_id, game)|
      seasons << game.season
    end.uniq


    team_id = team_id.to_i
    filtered_games = []

    @games.each do |game_id, game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        filtered_games.push(game)
      end
    end

    games_by_season = filtered_games.group_by do |fil_game|
      fil_game.season
    end

    games_by_type = {}
    games_by_season.each do |season_id, games_arr|
      random_hash = games_arr.group_by do |game|
        game.type
      end
      games_by_type[season_id] = random_hash
    end

    season_summary = {}
    games_by_type.each do |season_id, seasons_hash|
      season_summary[season_id] ||= {}
      seasons_hash.each do |season_type, games_arr|
        if season_type == 'Postseason'
          season_type = :postseason
        elsif season_type == 'Regular Season'
          season_type = :regular_season
        end
        season_summary[season_id][season_type] ||= {}
        win_avg = (games_arr.find_all do |game|
          (game.away_team_id == team_id && game.home_goals < game.away_goals) ||
          (game.home_team_id == team_id && game.home_goals > game.away_goals)
        end.length.to_f) / games_arr.length
        season_summary[season_id][season_type][:win_percentage] = win_avg.round(2)

        total_goals_s = 0
        total_goals_a = 0

        games_arr.each do |game|
          if game.home_team_id == team_id
            total_goals_s += game.home_goals
            total_goals_a += game.away_goals
          elsif game.away_team_id == team_id
            total_goals_a += game.home_goals
            total_goals_s += game.away_goals
          end
        end
        season_summary[season_id][season_type][:total_goals_scored] = total_goals_s.to_i
        season_summary[season_id][season_type][:total_goals_against] = total_goals_a.to_i
        season_summary[season_id][season_type][:average_goals_scored] = (total_goals_s.to_f / games_arr.length).round(2)
        season_summary[season_id][season_type][:average_goals_against] = (total_goals_a.to_f / games_arr.length).round(2)
      end
    end

    empty_summary = {
      win_percentage: 0.0,
      total_goals_scored: 0,
      total_goals_against: 0,
      average_goals_scored: 0.0,
      average_goals_against: 0.0
    }

    all_seasons.each do |season|
      if !season_summary[season].has_key?(:postseason)
        season_summary[season][:postseason] = empty_summary
      end
      if !season_summary[season].has_key?(:regular_season)
        season_summary[season][:regular_season] = empty_summary
      end
    end

    season_summary
  end

end
