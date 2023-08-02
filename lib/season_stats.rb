# require "./lib/stattracker.rb"
require "csv"

lines = File.readlines'./data/games_teams_fixture.csv'
lines.each do |line|
  puts line
end

class Season_Stats


  def winningest_coach 
    #Name of the Coach with the best win percentage for the season

  end

  def worst_coach
    #Name of the Coach with the worst win percentage for the season

  end

  def most_accurate_team
#Name of the Team with the best ratio of shots to goals for the season

  end

  def least_accurate_team
    # Name of the Team with the worst ratio of shots to goals for the season

  end

  def most_tackles
    # Name of the Team with the most tackles in the season

  end

  def fewest_tackles
    # Name of the Team with the fewest tackles in the season

  end
end
