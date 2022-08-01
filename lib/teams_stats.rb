require 'csv'
require_relative './teams'
require './helpable'

class TeamsStats
  include Helpable

  attr_reader :teams
  def initialize(teams)
    @teams = teams
  end

  def self.from_csv(location)
    teams = CSV.parse(File.read(location), headers: true, header_converters: :symbol).map(&:to_h)
    teams_as_objects = teams.map { |row| Teams.new(row) }
    TeamsStats.new(teams_as_objects)
  end

  def count_of_teams
    @teams.count { |team| team.team_id }
  end

  def team_info(team_id)
    team_hash = Hash.new(0)
    @teams.each do |team|
      if team_id == team.team_id
        team_hash["team_id"] = team.team_id
        team_hash["franchise_id"] = team.franchise_id
        team_hash["team_name"] = team.team_name
        team_hash["abbreviation"] = team.abbreviation
        team_hash["link"] = team.link
      end
    end
    team_hash
  end

  def most_accurate_team(season_id)
    ratio = get_ratio(season_id)
    max_ratio = ratio.max_by { |k, v| v }[0]
    @teams.each do |team|
      team_id = team.team_id
      team_name = team.team_name

      if team_id == max_ratio
        return team_name
      end
    end
  end

  def least_accurate_team(season_id)
    ratio = get_ratio(season_id)
    min_ratio = ratio.min_by { |k, v| v }[0]
    @teams.each do |team|
      team_id = team.team_id
      team_name = team.team_name

      if team_id == min_ratio
        return team_name
      end
    end
  end
  #methods

end
