require_relative 'loadable'

class Team
  @@accumulator = []
  extend Loadable
  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :stadium,
              :link

  def initialize(team_info)
    @team_id = team_info[:team_id]
    @franchiseid = team_info[:franchiseid]
    @teamname = team_info[:teamname]
    @abbreviation = team_info[:abbreviation]
    @stadium = team_info[:stadium]
    @link = team_info[:link]
  end

  def self.from_csv(games_file_path)
    load_csv(games_file_path, self)
  end

  def self.accumulator
    @@accumulator
  end
end
