require 'csv'
require './lib/game'
require './lib/season'
require './lib/team'

class GameTracker
  attr_reader :games

  def initialize
    @games = create
  end

  def create
    @games = []
    contents = CSV.open './data/games_stub.csv', headers:true, header_converters: :symbol
    contents.each do |row|
      game_id = row[:game_id]
      type = row[:type]
      date_time = row[:date_time]
      away_team_id = TeamTracker.teams.find {|team| team.id == row[:away_team_id]}
      home_team_id = row[:home_team_id]
      away_goals = row[:away_goals]
      home_goals = row[:home_goals]
      venue = row[:venue]
      venue_link = row[:venue_link]
      ###
      season = row[:season]

      link = row[:link]
      #@teams << Team.new(team_id, franchise_id, team_name, abbreviation, stadium, link)
    end
    #@games
  end
end
tracker = GameTracker.new
