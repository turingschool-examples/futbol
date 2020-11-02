class Team
  attr_reader :teamName,
              :franchiseId,
              :abbreviation,
              :link,
              :Stadium
  def initialize(row)
    @franchiseId = row["franchiseId"]
    @teamName = row["teamName"]
    @abbreviation = row["abbreviation"]
    @Stadium = row["Stadium"]
    @link = row["link"]
  end
end
