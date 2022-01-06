require 'csv'
require 'pry'

class StatTracker
  # include LeagueStatistics[@teams, @games, @game_teams]
  attr_reader :game_path, :team_path, :game_teams_path

  def initialize(files)
    @game_path = files[:games]
    @team_path = files[:teams]
    @game_teams_path = files[:game_teams]
    @teams = extract_team_data(@team_path)
  end

  def self.from_csv(files)
    stats = StatTracker.new(files)
  end

  def extract_team_data(team_path)
    data = CSV.read(team_path, :headers => true)
    data.each do |row|
      Team.new(row["team_id"])
    end
  end
end
