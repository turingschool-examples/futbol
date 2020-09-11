class GameTeamsStats
  attr_reader :game_data,
              :tracker

  def initialize(location, tracker)
    @game_teams_data = game_teams_stats(location)
    @tracker = tracker
  end

  def game_teams_stats(location)
    rows = CSV.read(location, { encoding: 'UTF-8', headers: true, header_converters: :symbol})
    result = []
    rows.each do |gameteam|
      gameteam.delete(:pim)
      gameteam.delete(:powerPlayOpportunities)
      gameteam.delete(:powerPlayGoals)
      gameteam.delete(:faceOffWinPercentage)
      gameteam.delete(:giveaways)
      gameteam.delete(:takeaways)
      result << GameTeams.new(gameteam, self)
    end
    result
  end

  def all_home_wins
  @game_teams_data.select do |game|
    game.hoa == "home" && game.result == "WIN"
    end
  end
end
