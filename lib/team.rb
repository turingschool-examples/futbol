require 'csv'

class Team
  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :stadium,
              :link

  @@teams = []

  def self.from_csv(file_path)
    csv = CSV.read(file_path, headers: true, header_converters: :symbol)
    @@teams = csv.map do |row|
      Team.new(row)
    end
  end

  def initialize(team_info)
    # require "pry"; binding.pry
    @team_id = team_info[:team_id].to_i
    @franchiseid = team_info[:franchiseid].to_i
    @teamname = team_info[:teamname]
    @abbreviation = team_info[:abbreviation]
    @stadium = team_info[:stadium]
    @link = team_info[:link]
  end
end
