require_relative 'game_team'

class Fans
  def self.best_fans
    home_wins = {}
    home_losses = {}
    away_wins = {}
    away_losses = {}
    home_win_percentages = {}
    away_win_percentages = {}
    home_away_win_differences = {}
    
    GameTeam.all_game_teams.each do |game|
      if !home_wins.include?(game.team_id)
        home_wins[game.team_id] = 0
        home_losses[game.team_id] = 0
        away_wins[game.team_id] = 0
        away_losses[game.team_id] = 0
      end
      
      if game.hoa == "home" && game.result == "WIN"
        home_wins[game.team_id] += 1
      elsif game.hoa == "home" && game.result == "LOSS"
        home_losses[game.team_id] += 1
      elsif game.hoa == "away" && game.result == "WIN"
        away_wins[game.team_id] += 1
      elsif game.hoa == "away" && game.result == "LOSS"
        away_losses[game.team_id] += 1
      end
    end
    
    home_wins.each do |team|
      total_games = home_wins[team[0]] + away_wins[team[0]] + home_losses[team[0]] + away_losses[team[0]]

      home_win_percentages[team[0]] = (home_wins[team[0]] / total_games.to_f).round(2)
      away_win_percentages[team[0]] = (away_wins[team[0]] / total_games.to_f).round(2)
      
      home_away_win_differences[team[0]] = (home_win_percentages[team[0]] - away_win_percentages[team[0]].abs).round(2)
    end
    
    best_fans_team_id = home_away_win_differences.key(home_away_win_differences.values.max)
    
    Team.all_teams.find do |team|
      team.team_id == best_fans_team_id
    end.team_name
  end
  
  def self.worst_fans
    home_wins = {}
    home_losses = {}
    away_wins = {}
    away_losses = {}
    home_win_percentages = {}
    away_win_percentages = {}
    
    GameTeam.all_game_teams.each do |game|
      if !home_wins.include?(game.team_id)
        home_wins[game.team_id] = 0
        home_losses[game.team_id] = 0
        away_wins[game.team_id] = 0
        away_losses[game.team_id] = 0
      end
      
      if game.hoa == "home" && game.result == "WIN"
        home_wins[game.team_id] += 1
      elsif game.hoa == "home" && game.result == "LOSS"
        home_losses[game.team_id] += 1
      elsif game.hoa == "away" && game.result == "WIN"
        away_wins[game.team_id] += 1
      elsif game.hoa == "away" && game.result == "LOSS"
        away_losses[game.team_id] += 1
      end
    end
    
    home_wins.each do |team|
      total_games = home_wins[team[0]] + away_wins[team[0]] + home_losses[team[0]] + away_losses[team[0]]

      home_win_percentages[team[0]] = (home_wins[team[0]] / total_games.to_f).round(3)
      away_win_percentages[team[0]] = (away_wins[team[0]] / total_games.to_f).round(3)
    end
    
    worst_fans_team_ids = []
    
    home_win_percentages.each do |team|
      if team[1] < away_win_percentages[team[0]]
        worst_fans_team_ids << team[0]
      end
    end
    
    worst_fans = []
    
    Team.all_teams.map do |team|
      if worst_fans_team_ids.include?(team.team_id)
        worst_fans << team.team_name
      end
    end
    
    worst_fans
  end
end