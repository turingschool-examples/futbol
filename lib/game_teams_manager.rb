class GameTeamsManager
  attr_reader :game_teams_data,
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
    @game_teams_data.select do |game_team|
      game_team.hoa == "home" && game_team.result == "WIN"
    end
  end

  def all_visitor_wins
    @game_teams_data.select do |game_team|
      game_team.hoa == "away" && game_team.result == "WIN"
    end
  end

  def count_of_ties
    double_ties = @game_teams_data.find_all do |game_team|
      game_team.result == "TIE"
    end
    double_ties.count / 2
  end

  def group_by_team_id
    @game_teams_data.group_by do |team|
      team.team_id
    end
  end

end
