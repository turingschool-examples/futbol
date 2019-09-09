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
    # require 'pry'; binding.pry
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
      # require 'pry'; binding.pry
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
    # require 'pry'; binding.pry
  end


end
