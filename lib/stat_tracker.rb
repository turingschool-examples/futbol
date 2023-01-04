require 'CSV'

class StatTracker
  attr_reader :games,
              :teams, 
              :game_teams,
              :game_id
             
  def initialize(locations)
    @games = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
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
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
    
  def highest_total_score
    total_scores = []
    @games.each do |row|
      total_scores << row[:away_goals].to_i + row[:home_goals].to_i
    end
    total_scores.max
  end

  def lowest_total_score
    total_scores = []
    @games.each do |row|
      total_scores << row[:away_goals].to_i + row[:home_goals].to_i
    end
    total_scores.min
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



  def count_of_teams 
    @teams.count
  end


  def find_team_id
    team = teams.map do |row|
      row[:team_id]
    end
  end
  # def best_offense


  # end

end



















