require "./lib/stat_daddy"
require "csv"
require "pry"

class SeasonStats < StatDaddy
  def winningest_coach(season)
    coach_wins = Hash.new(0)
    coach_games = Hash.new(0)
  end

  def worst_coach(season)
  end

  def most_accurate_team(season)
    # Name of the Team with the best ratio of shots to goals for the season
  end

  def least_accurate_team(season)
    # Name of the Team with the worst ratio of shots to goals for the season
  end

  def most_tackles(season)
    team_tackles = []
    # Name of the Team with the most tackles in the season
    @games_teams_fixture_path.each do |data|
      @team_id = data.team_id.to_i
      @tackles = data.tackles.to_i
      # team_tackles[@team_id] += @tackles
      @team_goals.each do |team_id, tackles|
        puts "Team ID #{team_id}: Total Tackles - #{tackles}"
      end
      tackles
    end
  end

  def fewest_tackles(season)
    @games_teams_fixture_path.each do |data|
      # Name of the Team with the fewest tackles in the season
    end
  end
end
