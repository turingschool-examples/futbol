require 'CSV'

class Stats
  attr_reader :game_stats_data,
              :game_teams_stats_data,
              :teams_stats_data

  def initialize(game_stats_data, game_teams_stats_data, teams_stats_data)
    @game_stats_data = self.game_stats
    @game_teams_stats_data = self.game_teams_stats
    @teams_stats_data = self.teams_stats
  end

  def game_stats
    rows = CSV.read('./data/games.csv', { encoding: 'UTF-8', headers: true, header_converters: :symbol})
    result = []
    rows.each do |game|
      # game.delete(:venue)
      # game.delete(:venue_link)
      result << Game.new(game)
    end
    result
  end

  def game_teams_stats
    rows = CSV.read('./data/game_teams.csv', { encoding: 'UTF-8', headers: true, header_converters: :symbol})
    result = []
    rows.each do |gameteam|
      # gameteam.delete(:pim)
      # gameteam.delete(:powerPlayOpportunities)
      # gameteam.delete(:powerPlayGoals)
      # gameteam.delete(:faceOffWinPercentage)
      # gameteam.delete(:giveaways)
      # gameteam.delete(:takeaways)
      result << GameTeams.new(gameteam)
    end
    result
  end

  def teams_stats
    teams_data = CSV.read('./data/teams.csv', { encoding: 'UTF-8', headers: true, header_converters: :symbol, converters: :all })
    result = []
    teams_data.each do |team|
      # team.delete(:stadium)
      result << Team.new(team)
    end
    result
  end
end
