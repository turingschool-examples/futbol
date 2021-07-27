require 'csv'

class Teams
  attr_reader :team_id,
              :franchise_id,
              :team_id,
              :abbreviation,
              :stadium,
              :link

  def initialize(row)
    @team_id = row["team_id"].to_i
    @franchise_id = row["franchiseID"].to_i
    @team_name = row["teamName"]
    @abbreviation = row["abbreviation"]
    @stadium = row["Stadium"]
    @link = row["link"]
  end

  # module, maybe?
  def self.file(file)
    rows = CSV.read(file, headers: true)
    rows.map do |row|
      new(row)
    end
  end
end