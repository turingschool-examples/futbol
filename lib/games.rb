require 'csv'
require './lib/games'

class Games
  attr_reader :game_id, :season, :type, :date_time, :away_team_id, :home_team_id, :away_goals, :home_goals, :venue, :venue_link

  def initialize(game_id, season, type, date_time, away_team_id, home_team_id, away_goals, home_goals, venue, venue_link)
    @game_id = game_id
    @season = season
    @type = type
    @date_time = date_time
    @away_team_id = away_team_id
    @home_team_id = home_team_id
    @away_goals = away_goals
    @home_goals = home_goals
    @venue = venue
    @venue_link = venue_link
  end

  def self.create(file_path)
    @games = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @games << self.new(row[:game_id],
                                    row[:season],
                                    row[:type],
                                    row[:date_time],
                                    row[:away_team_id],
                                    row[:home_team_id],
                                    row[:away_goals],
                                    row[:home_goals],
                                    row[:venue],
                                    row[:venue_link])
    end
    @games
  end

  def highest_total_score
  end

  def lowest_total_score
  end

  def biggest_blowout
  end

  def percentage_home_wins
  end

  def percentage_visitor_wins
  end

  def percentage_ties
  end

  def count_of_games_by_season
  end

  def average_goals_per_game
  end

  def average_goals_by_season
  end

end
