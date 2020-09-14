require_relative './team'
class TeamsManager
  attr_reader :teams, :tracker
  def initialize(teams_path, tracker)
    @teams = []
    @tracker = tracker
    create_games(teams_path)
  end

  def create_games(teams_path)
    teams_data = CSV.parse(File.read(teams_path), headers: true)
    @teams = teams_data.map do |data|
      Team.new(data, self)
    end
  end

  def count_of_teams
    @teams.count
  end

  def find_team_name(team_number)
    @teams.find do |team|
      team.team_id == team_number
    end.team_name
  end

  def average_number_of_goals_scored_by_team(team_id)
    @tracker.average_number_of_goals_scored_by_team(team_id)
  end

  def best_offense
    @teams.max_by do |team|
      team.average_goals
    end.team_name
  end

  def worst_offense
    @teams.min_by do |team|
      team.average_goals
    end.team_name
  end

  def average_number_of_goals_scored_by_team_by_type(team_id, home_away)
    @tracker.average_number_of_goals_scored_by_team_by_type(team_id, home_away)
  end

  def highest_scoring_visitor
    @teams.max_by do |team|
      team.avg_goals_visitor
    end.team_name
  end

  def lowest_scoring_visitor
    @teams.min_by do |team|
      team.avg_goals_visitor
    end.team_name
  end

  def highest_scoring_home
    @teams.max_by do |team|
      team.avg_goals_home
    end.team_name
  end

  def lowest_scoring_home
    @teams.min_by do |team|
      team.avg_goals_home
    end.team_name
  end

  def find_a_team(team_id)
    @teams.find do |team|
      team.team_id == team_id
    end
  end

  def team_info(team_id)
    team = find_a_team(team_id)
    team_info = {
      'team_id' => team.team_id,
      'franchise_id' => team.franchise_id,
      'team_name' => team.team_name,
      'abbreviation' => team.abbreviation,
      'link' => team.link
    }
  end

  def best_season(team_id)
    find_a_team(team_id).best_season
  end

  def worst_season(team_id)
    find_a_team(team_id).worst_season
  end

  def get_best_season(team_id)
    @tracker.get_best_season(team_id)
  end

  def get_worst_season(team_id)
    @tracker.get_worst_season(team_id)
  end
end
