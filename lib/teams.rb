require "csv"

class Teams
  @@all_teams = []

  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize(data)
    @team_id = data[:team_id]
    @franchise_id = data[:franchiseid]
    @team_name = data[:teamname]
    @abbreviation = data[:abbreviation]
    @stadium = data[:stadium]
    @link = data[:link]
  end

  def self.from_csv(path = "./data/teams_sample.csv")
    teams = []
    CSV.foreach(path, headers: true, converters: :numeric, header_converters: :symbol) do |row|
      teams << self.new(row)
    end
    @@all_teams = teams
  end

  def self.all_teams
    @@all_teams
  end
end
