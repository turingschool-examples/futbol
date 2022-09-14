require "csv"


class StatTracker
  attr_accessor :games_reader,
                :game_teams_reader,
                :teams_reader

  def initialize
    @teams_reader = nil
    @games_reader = nil
    @game_teams_reader = nil
  end

  def self.from_csv(locations)
    stat_tracker = new
    stat_tracker.teams_reader = CSV.read locations[:teams], headers: true, header_converters: :symbol
    stat_tracker.games_reader = CSV.read locations[:games], headers: true, header_converters: :symbol
    stat_tracker.game_teams_reader = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
    stat_tracker
  end

  def count_of_teams
   counter = 0
   @teams_reader.each do |row|
    counter += 1
   end
   counter
  end














































  def total_goals
    goal_totals = []
      @games_reader.each do |row|
        goal_totals << row[:away_goals].to_i + row[:home_goals].to_i
      end
    goal_totals
  end

  def highest_total_score
    total_goals.sort.last
  end

  def lowest_total_score
    total_goals.sort.first
  end

  def total_number_of_games
    count = 0
    @games_reader.each do |row|
      count += 1
    end
    count
  end

  def percentage_home_wins
  end

  def percentage_visitor_wins
  end

  def percentage_ties
  end
end

