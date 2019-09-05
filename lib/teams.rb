class Team
  attr_reader :team_id,
              :franchiseId,
              :teamName,
              :abbreviation,
              :stadium,
              :link

  def initialize(line)
    @team_id = line.split(",")[0]
    @franchiseId = line.split(",")[1]
    @teamName = line.split(",")[2]
    @abbreviation = line.split(",")[3]
    @stadium = line.split(",")[4]
    @link = line.split(",")[5]
  end

end
