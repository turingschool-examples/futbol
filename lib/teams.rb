class Teams 
  attr_reader :team_id,
              :franchiseId,
              :teamName,
              :abbreviation,
              :Stadium,
              :link,
              :tracker

  def initialize(data, tracker)
    @team_id = data[:team_id]
    @franchiseId = data[:franchiseId]
    @teamName = data[:teamName]
    @abbreviation = data[:abbreviation]
    @Stadium = data[:Stadium]
    @link = data[:link]
    @tracker = tracker
  end
end