class SeasonStats
  attr_reader :game_collection,
              :game_team_collection,
              :team_collection

  def initialize(game_collection, game_team_collection, team_collection)
    @game_collection = game_collection
    @game_team_collection = game_team_collection
    @team_collection = team_collection
  end

  def total_number_games_played
    number_of_games_played_home_team.merge!(number_of_games_played_away_team)  { |k, o, n| o + n }
  end

  def best_offense
    id_score = Hash.new(0)
    game_collection.games_array.map do |game|
      id_score[game.home_team_id] += game.home_goals.to_f
      id_score[game.away_team_id] += game.away_goals.to_f
    end
    id_score.merge!(total_number_games_played)  { |k, o, n| o / n }
    id = id_score.key(id_score.values.max)
    found = team_collection.teams_array.find do |team|
      team.team_id == id
    end
    found.team_name
  end

  def worst_offense
    id_score = Hash.new(0)
    game_collection.games_array.map do |game|
      id_score[game.away_team_id] += game.away_goals.to_i
      id_score[game.home_team_id] += game.home_goals.to_i
    end
    id_score.merge!(total_number_games_played)  { |k, o, n| o / n }
    id = id_score.key(id_score.values.min)
    found = team_collection.teams_array.find do |team|
      team.team_id == id
    end
    found.team_name
  end

  def winningest_coach(season_id)
    coach_number_games = Hash.new(0)
    @game_team_collection.game_teams_array.count do |game_team|
      if game_team.game_id.slice(0..3) == season_id.slice(0..3)
        coach_number_games[game_team.head_coach] += 1.0
      end
    end
    coach_n_wins = Hash.new(0)
    @game_team_collection.game_teams_array.count do |game_team|
      if game_team.result == "WIN" && game_team.game_id.slice(0..3) == season_id.slice(0..3)
        coach_n_wins[game_team.head_coach] += 1.0
      end
    coach_n_wins
    end
    coach_n_wins.merge!(coach_number_games) { |k, o, n| o / n }
    coach_n_wins.delete_if do |k,v|
      v > 1
    end
    coach_n_wins.key(coach_n_wins.values.max)
  end

  def worst_coach(season_id)
    coach_number_games = Hash.new(0)
    @game_team_collection.game_teams_array.count do |game_team|
      if game_team.game_id.slice(0..3) == season_id.slice(0..3)
        coach_number_games[game_team.head_coach] += 1.0
      end
    end
    coach_n_wins = Hash.new(0)
    @game_team_collection.game_teams_array.count do |game_team|
      if game_team.result == "LOSS" && game_team.game_id.slice(0..3) == season_id.slice(0..3)
        coach_n_wins[game_team.head_coach] += 1.0
      end
    coach_n_wins
    end
    coach_n_wins.merge!(coach_number_games) { |k, o, n| o / n }
    coach_n_wins.delete_if do |k,v|
      v > 1
    end
    coach_n_wins.key(coach_n_wins.values.max)
  end


  def most_accurate_team(season_id)
    team_id = game_teams_in_season(season_id).max_by do |game|
      game.goals.to_f / game.shots.to_f
    end.team_id.to_i
    @team_collection.team_name_by_id(team_id)
  end

  def game_teams_in_season(season_id)
    @game_team_collection.game_teams_array.find_all do |game_team|
      season_id.slice(0..3) == game_team.game_id.slice(0..3)
    end
  end

  def least_accurate_team(season_id)
    team_id = game_teams_in_season(season_id).min_by do |game|
      game.goals.to_f / game.shots.to_f
    end.team_id.to_i
    @team_collection.team_name_by_id(team_id)
  end

  def most_tackles(season_id)
    coach_tackles = Hash.new(0)
    @game_team_collection.game_teams_array.each do |game_team|
      if game_team.game_id.slice(0..3) == season_id.slice(0..3)
        coach_tackles[game_team.team_id] += game_team.tackles.to_i
      end
    end
    id_number = coach_tackles.key(coach_tackles.values.max)
    @team_collection.team_name_by_id(id_number.to_i)
  end

  def fewest_tackles(season_id)
    coach_tackles = Hash.new(0)
    @game_team_collection.game_teams_array.each do |game_team|
      if game_team.game_id.slice(0..3) == season_id.slice(0..3)
        coach_tackles[game_team.team_id] += game_team.tackles.to_i
      end
    end
    id_number = coach_tackles.key(coach_tackles.values.min)
    @team_collection.team_name_by_id(id_number.to_i)
  end

  def number_of_games_vs_oppenent(team_id)
    total_games = Hash.new(0)
    @game_collection.games_array.each do |team|
      if team.home_team_id == team_id.to_s
        total_games[team.away_team_id] += 1.0
      else team.away_team_id == team_id.to_s
        total_games[team.home_team_id] += 1.0
      end
    end
    total_games
  end

  def favorite_opponent(team_id)
    games_won_vs_opponent = Hash.new(0)
    @game_collection.games_array.each do |team|
      if team.home_team_id || team.away_team_id == team_id.to_s
        if (team.home_team_id == team_id.to_s) && (team.home_goals > team.away_goals)
          games_won_vs_opponent[team.away_team_id] += 1.0
        else (team.away_team_id == team_id.to_s) && (team.away_goals > team.home_goals)
          games_won_vs_opponent[team.home_team_id] += 1.0
        end
      end
    end
    games_won_vs_opponent.merge!(number_of_games_vs_oppenent(team_id)) { |k, o, n| o / n }
    games_won_vs_opponent.delete_if do |k,v|
      v > 1
    end
    id = games_won_vs_opponent.key(games_won_vs_opponent.values.max)
    found = @team_collection.teams_array.find do |team|
      if team.team_id == id
        return team.team_name
      end
      found
    end
  end

  def rival(team_id)
    games_lost_vs_opponent = Hash.new(0)
    @game_collection.games_array.each do |team|
      if team.home_team_id || team.away_team_id == team_id.to_s
        if (team.home_team_id == team_id.to_s) && (team.home_goals < team.away_goals)
          games_lost_vs_opponent[team.away_team_id] += 1.0
        else (team.away_team_id == team_id.to_s) && (team.away_goals < team.home_goals)
          games_lost_vs_opponent[team.home_team_id] += 1.0
        end
      end
    end
    games_lost_vs_opponent.merge!(number_of_games_vs_oppenent(team_id)) { |k, o, n| o / n }
    games_lost_vs_opponent.delete_if do |k,v|
      v > 1
    end
    id = games_lost_vs_opponent.key(games_lost_vs_opponent.values.max)
    found = @team_collection.teams_array.find do |team|
      if team.team_id == id
        return team.team_name
      end
      found
    end
  end
  def number_of_games_played_home_team
    @game_collection.games_array.reduce(Hash.new(0)) do |team, game|
      team[game.home_team_id] += 1.0
      team
    end
  end

  def number_of_games_played_away_team
    @game_collection.games_array.reduce(Hash.new(0)) do |team, game|
      team[game.away_team_id] += 1.0
      team
    end
  end

  def highest_scoring_visitor
    away_team_goals = @game_collection.games_array.reduce(Hash.new(0)) do |team, game|
      team[game.away_team_id] += game.away_goals.to_f
      team
    end
    away_team_goals.merge!(number_of_games_played_away_team) { |k, o, n| o / n }
    id = away_team_goals.key(away_team_goals.values.max)
    found = team_collection.teams_array.find do |team|
      team.team_id == id
    end
    found.team_name
  end

  def highest_scoring_home_team
    home_team_goals = @game_collection.games_array.reduce(Hash.new(0)) do |team, game|
      team[game.home_team_id] += game.home_goals.to_f
      team
    end
    home_team_goals.merge!(number_of_games_played_home_team) { |k, o, n| o / n }
    id = home_team_goals.key(home_team_goals.values.max)
    found = team_collection.teams_array.find do |team|
      team.team_id == id
    end
    found.team_name
  end

  def lowest_scoring_visitor
    away_team_goals = game_collection.games_array.reduce(Hash.new(0)) do |team, game|
      team[game.away_team_id] += game.away_goals.to_f
      team
    end
    away_team_goals.merge!(number_of_games_played_away_team) { |k, o, n| o / n }
    id = away_team_goals.key(away_team_goals.values.min)
    found = team_collection.teams_array.find do |team|
      team.team_id == id
    end
    found.team_name
  end

  def lowest_scoring_home_team
    home_team_goals = game_collection.games_array.reduce(Hash.new(0)) do |team, game|
      team[game.home_team_id] += game.home_goals.to_f
      team
    end
    home_team_goals.merge!(number_of_games_played_home_team) { |k, o, n| o / n }
    id = home_team_goals.key(home_team_goals.values.min)
    found = team_collection.teams_array.find do |team|
      team.team_id == id
    end
    found.team_name
  end
end
