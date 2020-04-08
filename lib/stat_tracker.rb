require 'CSV'
require 'pry'
class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(data_files)
    @games = data_files[:games]
    @teams = data_files[:teams]
    @game_teams = data_files[:game_teams]
  end

  def self.from_csv(data_files)
      StatTracker.new(data_files)
  end

  def game_data
    CSV.foreach(@games,headers: true, header_converters: :symbol) do |row|
      # puts row.inspect
      game_id = row[:game_id]
    #   season
    #   ,type,
    #   date_time,away_team_id,home_team_id,away_goals,home_goals,venue,venue_link
    # end

    puts game_id
  end

  end
end
