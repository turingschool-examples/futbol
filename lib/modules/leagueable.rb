module Leagueable

  def count_of_teams
    teams.length
  end

  def best_offense
    best_offense_team = teams.values.max_by do |team|
      team.total_goals/team.games.length.to_f
    end
    best_offense_team.name
  end

  def worst_offense
    worst_offense_team = teams.values.min_by do |team|
      team.total_goals/team.games.length.to_f
    end
    worst_offense_team.name
  end

  def best_defense
    best_defense_team = teams.values.min_by do |team|
      team.total_goals_allowed/team.games.length.to_f
    end
    best_defense_team.name
  end

  def worst_defense
    worst_defense_team = teams.values.max_by do |team|
      team.total_goals_allowed/team.games.length.to_f
    end
    worst_defense_team.name
  end

  def highest_scoring_visitor
    best_visitor = teams.values.max_by do |team|
      team.total_away_goals/team.total_away_games.to_f
    end
    best_visitor.name
  end

  def highest_scoring_home_team
    best_home_team = teams.values.max_by do |team|
      team.total_home_goals/team.total_home_games.to_f
    end
    best_home_team.name
  end

  def lowest_scoring_visitor
    worst_visitor = teams.values.min_by do |team|
      team.total_away_goals/team.total_away_games.to_f
    end
    worst_visitor.name
  end

  def lowest_scoring_home_team
    worst_home_team = teams.values.min_by do |team|
      team.total_home_goals/team.total_home_games.to_f
    end
    worst_home_team.name
  end

  def winningest_team
    winningest = teams.values.max_by do |team|
      team.total_wins/team.games.length.to_f
    end
    winningest.name
  end

  ###################################################
  # These need to be refactored.                    #
  # total_home/away_games is an expensive operation #
  # These are also basically the same methods       #
  ###################################################

  def best_fans
    home_away_hash = {}

    teams.values.each do |team|
      home_game_wins = 0
      away_game_wins = 0
      team.games.values.each do |game|
        if team.win?(game)
          home_game_wins += 1 if team.home_team?(game)
          away_game_wins += 1 if !team.home_team?(game)
        end
      end
      
      home_win_percentage = home_game_wins / team.total_home_games.to_f
      away_win_percentage = away_game_wins / team.total_away_games.to_f
      
      home_away_hash[team] = home_win_percentage - away_win_percentage
    end
    home_away_hash.max_by { |_, value| value }.first.name
  end

  def worst_fans
    home_away_hash = {}

    teams.values.each do |team|
      home_game_wins = 0
      away_game_wins = 0
      team.games.values.each do |game|
        if team.win?(game)
          home_game_wins += 1 if team.home_team?(game)
          away_game_wins += 1 if !team.home_team?(game)
        end
      end
      
      home_win_percentage = home_game_wins / team.total_home_games.to_f
      away_win_percentage = away_game_wins / team.total_away_games.to_f
      
      home_away_hash[team] = home_win_percentage - away_win_percentage
    end
    home_away_hash
      .select { |team, percentage| percentage < 0.0 }
      .keys.map { |team| team.name }
  end
end
