class Team
  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium, :link

  def initialize(team_info, all_team_games, all_opponent_games)
    @team_id = team_info[:team_id]
    @franchise_id = team_info[:franchiseid].to_i
    @team_name = team_info[:teamname]
    @abbreviation = team_info[:abbreviation]
    @all_team_games = all_team_games
    @all_opponent_games = all_opponent_games
  end

  def win_percentage
    win_count = @all_team_games.count do |game|
      game.result == "WIN"
    end
    (win_count / @all_team_games.length.to_f).round(2)
  end

  def average_goals_scored_per_game
    goal_count = @all_team_games.sum do |game|
      game.goals
    end
    (goal_count / @all_team_games.length.to_f).round(2)
  end

  def average_goals_allowed_per_game
    goal_count = @all_opponent_games.sum do |game|
      game.goals
    end
    (goal_count / @all_opponent_games.length.to_f).round(2)
  end

  def home_win_percentage
    total_home_games = 0
    win_count = @all_team_games.count do |game|
      if game.hoa == "home"
        total_home_games += 1
      end
      game.result == "WIN" && game.hoa == "home"
    end
    (win_count.to_f / total_home_games * 100).round(2)
  end



  def away_win_percentage
    total_away_games = 0
    win_count = @all_team_games.count do |game|
      if game.hoa == "away"
        total_away_games += 1
      end
      game.result == "WIN" && game.hoa == "away"

    end
    (win_count.to_f / total_away_games * 100).round(2)
  end
end
