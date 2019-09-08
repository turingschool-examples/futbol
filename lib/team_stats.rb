module TeamStats

  def team_info(team_id)
    info = {}
    info["team_id"] = @teams[team_id].team_id
    info["franchiseId"] = @teams[team_id].franchiseId
    info["teamName"] = @teams[team_id].teamName
    info["abbreviation"] = @teams[team_id].abbreviation
    info["link"] = @teams[team_id].link
    info
  end

  def worst_and_best_season(team_id)
    seasons = Hash.new(0)
    game_ids = []
    @game_teams[team_id].each {|game| game_ids << game.game_id}
    @game_count_by_season = Hash.new(0)
    game_ids.each do |game_id|
      if @games[game_id].home_team_id == team_id
        @game_count_by_season[@games[game_id].season] += 1
        if @games[game_id].home_goals > @games[game_id].away_goals
          seasons[@games[game_id].season] += 1
        end
      elsif @games[game_id].away_team_id == team_id
        @game_count_by_season[@games[game_id].season] += 1
        if @games[game_id].away_goals > @games[game_id].home_goals
          seasons[@games[game_id].season] += 1
        end
      end
    end
    seasons = seasons.each do |season, wins|
    seasons[season] = ((wins.to_f / @game_count_by_season[season]) * 100).round(2)
    end
    max = seasons.max_by {|id, count| count}[0]
    min = seasons.min_by {|id, count| count}[0]
    @min_max = [min, max]
  end

  def best_season(team_id)
    worst_and_best_season(team_id)[1]
  end

  def worst_season(team_id)
    worst_and_best_season(team_id)[0]
  end

  def average_win_percentage(team_id)
    (calculate_percents[2][team_id]/100).round(2)
  end

  def most_goals_scored(team_id)
    @game_teams[team_id].max_by{ |object| object.goals }.goals
  end

  def fewest_goals_scored(team_id)
    @game_teams[team_id].min_by{ |object| object.goals }.goals
  end

  def best_and_worst_opponent(team_id)
    games = []
    opponent_games = Hash.new(0)
    opponent_wins = Hash.new(0)
    @games.each do |game_id, game|
      if team_id == game.home_team_id && game.away_goals > game.home_goals
        opponent_games[game.away_team_id] += 1
        opponent_wins[game.away_team_id] += 1
      elsif team_id == game.home_team_id && game.away_goals <= game.home_goals
        opponent_games[game.away_team_id] += 1
        opponent_wins[game.away_team_id] += 0
      end
      if team_id == game.away_team_id && game.home_goals > game.away_goals
        opponent_games[game.home_team_id] += 1
        opponent_wins[game.home_team_id] += 1
      elsif team_id == game.away_team_id && game.home_goals <= game.away_goals
        opponent_games[game.home_team_id] += 1
        opponent_wins[game.home_team_id] += 0
      end
    end
    opponent_percent = {}
    opponent_wins.each {|opponent, wins| opponent_percent[opponent] = ((wins.to_f / opponent_games[opponent]) * 100).round(2) }
    min = opponent_percent.min_by{ |opp, percent| percent }[0]
    max = opponent_percent.max_by{ |opp, percent| percent }[0]
    min_team = @teams[min].teamName
    max_team = @teams[max].teamName
    [min_team, max_team]
  end


    # games.each do |game|
    #   if game.home_team_id == team_id
    #     opponent_wins[game.away_team_id] += 0
    #     opponent_games[game.away_team_id] += 1
    #     if game.away_goals > game.home_goals
    #       opponent_wins[game.away_team_id] += 1
    #     end
    #   elsif game.away_team_id == team_id
    #     opponent_wins[game.home_team_id] += 0
    #     opponent_games[game.home_team_id] += 1
    #     if game.home_goals > game.away_goals
    #       opponent_wins[game.home_team_id] += 1
    #     end
    #   end
    # end
    # opponent_percent = {}
    # opponent_wins.each {|opponent, wins|
    #   opponent_percent[opponent] = ((wins.to_f / opponent_games[opponent]) * 100).round(2)
    # }


  def favorite_opponent(team_id)
    best_and_worst_opponent(team_id)[0]
  end

  def rival(team_id)
    best_and_worst_opponent(team_id)[1]
  end

  def test_biggest_team_blowout(team_id)

  end

end
