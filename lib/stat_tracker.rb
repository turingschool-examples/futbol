require 'CSV'

class StatTracker
  attr_reader :games,
              :teams, 
              :game_teams,
              :game_id,
              :total_score_array
             
  def initialize(locations)
    @games = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    @total_score_array = total_score
    @games_by_season = count_of_games_by_season

    @game_id = @games[:game_id]
    @season = @games[:season]
    @type = @games[:type].to_s
    @date_time = @games[:date_time]
    @away_team_id = @games[:away_team_id]
    @home_team_id = @games[:home_team_id]
    @away_goals = @games[:away_goals]
    @home_goals = @games[:home_goals]
    @venue = @games[:venue].to_s
    @venue_link = @games[:venue_link].to_s
    @total_scores = []
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
   
  def total_score
    total_score_array = []
    @games.each do |row|
      total_score_array << row[:away_goals].to_i + row[:home_goals].to_i
    end
    total_score_array
  end

  def highest_total_score
    total_score
    @total_score_array.max
  end

  def lowest_total_score
    total_score
    @total_score_array.min
  end

  def percentage_home_wins
    count = @games.count do |row|
      row[:home_goals].to_i > row[:away_goals].to_i
    end
    (count.to_f / @games.size).round(2)
  end

  def percentage_visitor_wins
    count = @games.count do |row|
      row[:away_goals].to_i > row[:home_goals].to_i
    end
    (count.to_f / @games.size).round(2)
  end

  def percentage_ties
    count = @games.count do |row|
      row[:away_goals].to_i == row[:home_goals].to_i
    end
    (count.to_f / @games.size).round(2)
  end
end



















