module SeasonStatistics


  def biggest_bust(season)
    games_by_team = @game_teams.group_by do |game_team|
      game_team.team_id
    end
    games_by_team.each do |team_id, games|
      ps_game = games.find_all do |game|
        @games[game.game_id].type == "Postseason"
      end
    end
  end

  def most_tackles(season_id)
    filtered_games = @game_teams.find_all do |game|
      @games[game.game_id].season == season_id
    end

    games_by_teams = filtered_games.group_by(&:team_id)

    most_tackles_team_id = nil
    most_tackles = 0
    games_by_teams.each do |team_id, games_arr|
      tackles = games_arr.sum {|game| game.tackles}
      if tackles > most_tackles
        most_tackles_team_id = team_id
        most_tackles = tackles
      end
    end
    @teams[most_tackles_team_id].team_name
  end

  def fewest_tackles(season_id)
    filtered_games = @game_teams.find_all do |game|
      @games[game.game_id].season == season_id
    end

    games_by_teams = filtered_games.group_by(&:team_id)

    fewest_tackles_team_id = nil
    fewest_tackles = 100_000
    games_by_teams.each do |team_id, games_arr|
      tackles = games_arr.sum {|game| game.tackles}
      if tackles < fewest_tackles
        fewest_tackles_team_id = team_id
        fewest_tackles = tackles
      end
    end
    @teams[fewest_tackles_team_id].team_name
  end

  def least_accurate_team(season_id)
    filtered_games = @game_teams.find_all do |game|
      @games[game.game_id].season == season_id
    end

    games_by_teams = filtered_games.group_by(&:team_id)

    lowest_ratio_team_id = nil
    lowest_ratio = 10
    games_by_teams.each do |team_id, games_arr|
      shot_ratio = games_arr.sum(&:goals).to_f / games_arr.sum(&:shots)
      # require 'pry'; binding.pry
      if shot_ratio < lowest_ratio
        lowest_ratio_team_id = team_id
        lowest_ratio = shot_ratio
      end
    end
    @teams[lowest_ratio_team_id].team_name
  end

  def most_accurate_team(season_id)
    filtered_games = @game_teams.find_all do |game|
      @games[game.game_id].season == season_id
    end

    games_by_teams = filtered_games.group_by(&:team_id)

    highest_ratio_team_id = nil
    highest_ratio = 10
    games_by_teams.each do |team_id, games_arr|
      shot_ratio = games_arr.sum(&:shots).to_f / games_arr.sum(&:goals)
      if shot_ratio < highest_ratio
        highest_ratio_team_id = team_id
        highest_ratio = shot_ratio
      end
    end
    @teams[highest_ratio_team_id].team_name
  end

  def winningest_coach(season_id)
    filtered_games = @game_teams.find_all do |game|
      @games[game.game_id].season == season_id
    end

    games_by_coaches = filtered_games.group_by(&:head_coach)

    most_wins_coach_name = nil
    highest_win_percentage = 0
    games_by_coaches.each do |coach_name, games_arr|
      win_percentage = (games_arr.find_all do |game|
        game.result == "WIN"
      end.length).to_f / games_arr.length
      if win_percentage > highest_win_percentage
        most_wins_coach_name = coach_name
        highest_win_percentage = win_percentage
      end
    end
    most_wins_coach_name
  end

  def worst_coach(season_id)
    filtered_games = @game_teams.find_all do |game|
      @games[game.game_id].season == season_id
    end

    games_by_coaches = filtered_games.group_by(&:head_coach)

    fewest_wins_coach_name = nil
    lowest_win_percentage = 100
    games_by_coaches.each do |coach_name, games_arr|
      win_percentage = (games_arr.find_all do |game|
        game.result == "WIN"
      end.length).to_f / games_arr.length
      if win_percentage < lowest_win_percentage
        fewest_wins_coach_name = coach_name
        lowest_win_percentage = win_percentage
      end
    end
    fewest_wins_coach_name
  end
end
