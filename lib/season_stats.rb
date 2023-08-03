require_relative "game_teams"
require "csv"
require "pry"

class SeasonStats
  def initialize(locations)
    @games_teams_fixture_path = CSV.open(locations[:games_teams_fixture_path], headers: true, header_converters: :symbol).map { |game_team| GameTeams.new(game_team) }
  end

  def winningest_coach
    @games_teams_fixture_path.each do |data|
      # Name of the Coach with the best win percentage for the season
    end
  end

  def worst_coach
    # Name of the Coach with the worst win percentage for the season
  end

  def most_accurate_team
    # Name of the Team with the best ratio of shots to goals for the season
  end

  def least_accurate_team
    # Name of the Team with the worst ratio of shots to goals for the season
  end

  def most_tackles
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

  def fewest_tackles
    @games_teams_fixture_path.each do |data|
      # Name of the Team with the fewest tackles in the season
    end
  end
end
