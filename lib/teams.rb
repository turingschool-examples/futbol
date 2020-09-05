require "csv"

class Teams
  @@all_teams = []

  def initialize(data)
    @team_id = data[:team_id]
    @franchiseid = data[:franchise_id]
    @teamname = data[:teamname]
    @abbreviation = data[:abbreviation]
    @stadium = data[:stadium]
    @link = data[:link]
  end

  def self.from_csv(path = "./data/teams_test.csv")
    teams = []
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      teams << self.new(row)
    end
    @@all_teams = teams
  end

  def self.all_teams
    @@all_teams
  end
end
