require './lib/helper_class'

module Games
  def best_offense
    team_goals = Hash.new(0)

    TeamPerformance.games.each do |team_performance|
      home_team_name = team_performance.home_team_name
      away_team_name = team_performance.away_team_name
      home_team_goals = team_performance.home_team_goals
      away_team_goals = team_performance.away_team_goals

      team_goals[home_team_name] += home_team_goals

      team_goals[away_team_name] += away_team_goals
    end
    
    require 'pry';binding.pry

    total_goals_per_team = team_goals.map do |team_name, total_goals|
      { team_name: team_name, total_goals: total_goals }
    end

    total_goals_per_team.max_by { |team| team[:total_goals] }[:team_name]
  end

  def worst_offense
    team_goals = Hash.new(0)


    TeamPerformance.games.each do |team_performance|
      home_team_name = team_performance.home_team_name
      away_team_name = team_performance.away_team_name
      home_team_goals = team_performance.home_team_goals
      away_team_goals = team_performance.away_team_goals

      team_goals[home_team_name] += home_team_goals

      team_goals[away_team_name] += away_team_goals
    end

    total_goals_per_team = team_goals.map do |team_name, total_goals|
      { team_name: team_name, total_goals: total_goals }
    end

    total_goals_per_team.min_by { |team| team[:total_goals] }[:team_name]
  end
end