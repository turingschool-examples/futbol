# use require_relative
class Game 

attr_reader :game_id, 
            :season, 
            :type, 
            :date_time, 
            :away_team_id,
            :home_team_id,
            :away_goals,
            :home_goals, 
            :venue, 
            :venue_link

  def initialize(file)
    @games = (CSV.open file[:games], headers: true, header_converters: :symbol).map { |row| Game.new(row) }
    require 'pry'; binding.pry
        @game_id = row[:game_id],
        @season = row[:season],
        @type = row[:type],
        @date_time = row[:date_time],
        @away_team_id = row[:away_team_id],
        @home_team_id = row[:home_team_id],
        @away_goals = row[:away_goals],
        @home_goals = row[:home_goals],
        @venue = row[:venue],
        @venue_link = row[:venue_link]
      
  end

  # def highest_total_score
  #   method
  # end

  # def lowest_total_score
  #   method
  # end

  # def percentage_home_wins
  #   @games. (method for calculating this)
  # end

  # def percentage_visitor_wins
  #   method
  # end

  # def percentage_ties
  #   method
  # end

  # def count_of_games_by_season
  #   method
  # end

  # def average_goals_per_game
  #   method
  # end

  # def average_goals_by_season
  #   method
  # end
end
