class TeamTracker < Statistics

  # USE THIS METHOD TEAM INFO
  def team_info(team_id)
    team_hash = {}
    team = @teams.find do |team|
      team.team_id == team_id
    end
    team.instance_variables.each do |variable|
      variable = variable.to_s.delete! '@'
      team_hash[variable.to_sym] = team.instance_variable_get("@#{variable}".to_sym)
    end
    team_hash
  end

  def best_season(team_id)
    all_games = @games.find_all do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end
    reg_games = all_games.find_all do |game|
      game.type == "Regular Season"
    end
    games_by_season = reg_games.group_by do |game|
      game.season
    end
    win_hash = Hash.new { |hash, key| hash[key] = [] }
    games_by_season.each_pair do |season, games|
      games.each do |game|
        @game_teams.find_all do |game_2|
          win_hash[season] << game_2 if game.game_id == game_2.game_id
        end
      end
    end
    hash = Hash.new
    win_hash.each_pair do |season, games|
      wins = games.count do |game|
        game.result == "WIN"
      end
      ties = games.count do |game|
        game.result == "TIE"
      end
      hash[season] = (wins.to_f + (ties/2))/ win_hash[season].length
    end
    require "pry"; binding.pry
  end
end
#tracker = TeamTracker.new
#p tracker.teams
#p tracker.team_info(tracker.teams[1])
