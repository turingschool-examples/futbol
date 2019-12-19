require 'csv'
require_relative 'csv_loadable'

class Team
  extend CsvLoadable
  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :stadium,
              :link

  @@teams = []

  def self.from_csv(file_path)
    create_instances(file_path, Team)
    @@teams = @objects
  end

  def initialize(team_info)
    @team_id = team_info[:team_id].to_i
    @franchiseid = team_info[:franchiseid].to_i
    @teamname = team_info[:teamname]
    @abbreviation = team_info[:abbreviation]
    @stadium = team_info[:stadium]
    @link = team_info[:link]
  end
end
