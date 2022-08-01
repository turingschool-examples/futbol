module Leagueable
  def team_average_goals
    team_hash = Hash.new()
    @game_teams_data.each do |row|
      team_hash[row[:team_id]] = []
    end
    @game_teams_data.each do |row|
      team_hash[row[:team_id]] << row[:goals].to_i 
    end
    team_average_goals = Hash.new()
    team_hash.each do |team, goals|
      team_average_goals[team] = (goals.sum.to_f / goals.length).round(2)
    end
    team_average_goals
  end

  def team_away_average_goals
    team_hash = Hash.new()
    @game_teams_data.each do |row|
      team_hash[row[:team_id]] = []
    end
    @game_teams_data.each do |row|
      if row[:hoa] == "away"
        team_hash[row[:team_id]] << row[:goals].to_i
      end
    end
    team_away_average_goals = Hash.new()
    team_hash.each do |team, goals|
      team_away_average_goals[team] = (goals.sum.to_f / goals.length).round(2)
    end
    team_away_average_goals
  end

  def team_home_average_goals
    team_hash = Hash.new()
    @game_teams_data.each do |row|
      team_hash[row[:team_id]] = []
    end
    @game_teams_data.each do |row|
      if row[:hoa] == "home"
        team_hash[row[:team_id]] << row[:goals].to_i
      end
    end
    team_home_average_goals = Hash.new()
    team_hash.each do |team, goals|
      team_home_average_goals[team] = (goals.sum.to_f / goals.length).round(2)
    end
    team_home_average_goals
  end
end