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
   @teams_reader.length
  end














































  def unique_total_goals
    goal_totals = []
      @games_reader.each do |row|
        if goal_totals.include?(row[:away_goals].to_i + row[:home_goals].to_i) == false
          goal_totals << row[:away_goals].to_i + row[:home_goals].to_i
        end
      end
    goal_totals
  end

  def highest_total_score
    unique_total_goals.max
  end

  def lowest_total_score
    unique_total_goals.min
  end

  def total_number_of_games
    @games_reader.length
  end

  def percentage_home_wins
   home_win_total = @game_teams_reader.count {|row| row[:result] == "WIN" && row[:hoa] == "home"}.to_f.round(2)
   home_win_total*100/total_number_of_games
  end

  def percentage_visitor_wins
    home_visitor_total = @game_teams_reader.count {|row| row[:result] == "WIN" && row[:hoa] == "away"}.to_f.round(2)
    home_visitor_total*100/total_number_of_games
  end

  def percentage_ties
    tie_total = @game_teams_reader.count {|row| row[:result] == "TIE" && row[:hoa] == "home"}.to_f.round(2)
    tie_total*100/total_number_of_games
  end


  def team_info(team)
      {team_id: team.team_id,
      franchise_id: team.franchise_id,
      team_name: team.team_name,
      abbreviation: team.abbreviation,
      stadium: team.stadium,
      link: team.link}
  end
end
