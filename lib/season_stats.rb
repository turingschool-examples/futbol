require 'csv'

class SeasonStats
  
  def initialize
    @teams = CSV.open('./data/teams.csv', headers: true, header_converters: :symbol).map { |row| Team.new(row) }
    @game_teams = CSV.open('./data/game_teams.csv', headers: true, header_converters: :symbol).map { |row| GameTeams.new(row) }
  end

  def most_accurate_team(season)
    team = @teams.select do |team|
     team.team_id == team_id_best_shot_perc_by_season(season)
    end
    team.first.team_name
  end

  def least_accurate_team(season)
    team = @teams.select do |team|
     team.team_id == team_id_worst_shot_perc_by_season(season)
    end
    team.first.team_name
  end

  def all_goals_by_team_by_season(season)
    team_goals_season = Hash.new(0)
    @game_teams.each do |game|
      if season == game.season_id
      team_goals_season[game.team_id] += game.goals.to_i
      end
    end
    team_goals_season
  end

  def all_shots_by_team_by_season(season)
    team_shots_season = Hash.new(0)
    @game_teams.each do |game|
      if season == game.season_id
      team_shots_season[game.team_id] += game.shots.to_i
      end
    end
    team_shots_season
  end

  def teams_shot_percentage_by_season(season)
    all_goals_by_team_by_season(season).merge(all_shots_by_team_by_season(season)) do |team_id, goals, shots|
      goals.fdiv(shots)
    end
  end

  def team_id_best_shot_perc_by_season(season)
    team_id = teams_shot_percentage_by_season(season).max_by {|_, percentage| percentage}
    team_id.first
  end

  def team_id_worst_shot_perc_by_season(season)
    team_id = teams_shot_percentage_by_season(season).min_by {|_, percentage| percentage}
    team_id.first
  end  

  ###not pretty but it works, good opportunity to refactor###
  def winningest_coach(season_year)
    total_game_hash = Hash.new(0)
    win_coach_hash = Hash.new(0)
    @game_teams.each do |game|
      if game.season_id == season_year
        total_game_hash[game.coach] += 1
        win_coach_hash[game.coach] = 0 
      end
    end
    @game_teams.each do |game|
      if game.season_id == season_year
        if game.result == "WIN"
          win_coach_hash[game.coach] += 1
        end
      end
    end
    total_game_hash.merge!(win_coach_hash) {|coach, games, wins| wins.to_f / games}
    total_game_hash.key(total_game_hash.values.max)
  end
  
###same as the one above, ripe for refactor###
  def worst_coach(season_year)
    total_game_hash = Hash.new(0)
    win_coach_hash = Hash.new(0)
    @game_teams.each do |game|
      if game.season_id == season_year
        total_game_hash[game.coach] += 1
        win_coach_hash[game.coach] = 0 
      end
    end
    @game_teams.each do |game|
      if game.season_id == season_year
        if game.result == "WIN"
          win_coach_hash[game.coach] += 1
        end
      end
    end
    total_game_hash.merge!(win_coach_hash) {|coach, games, wins| wins.to_f / games}
    total_game_hash.key(total_game_hash.values.min)
  end

  def most_tackles(season_year)
    most_tackle_hash = Hash.new(0)
    @game_teams.each do |game|
      if game.season_id == season_year
        most_tackle_hash[game.team_id] += game.tackles.to_i
      end
    end
    @teams.each do |team| 
      if team.team_id == most_tackle_hash.key(most_tackle_hash.values.max)
        return team.team_name
      end
    end
  end

  def fewest_tackles(season_year)
    least_tackle_hash = Hash.new(0)
    @game_teams.each do |game|
      if game.season_id == season_year
        least_tackle_hash[game.team_id] += game.tackles.to_i
      end
    end
    @teams.each do |team| 
      if team.team_id == least_tackle_hash.key(least_tackle_hash.values.min)
        return team.team_name
      end
    end
  end
end


