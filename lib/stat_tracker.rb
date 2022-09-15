require 'csv'

class StatTracker

  attr_reader :game_path, :team_path, :game_teams_path

  def initialize(game_path, team_path, game_teams_path)
    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path
    @game_csv = CSV.read(@game_path, headers: true, header_converters: :symbol)
    @team_csv = CSV.read(@team_path, headers: true, header_converters: :symbol)
    @game_teams_csv = CSV.read(@game_teams_path, headers: true, header_converters: :symbol)
  end

  def self.from_csv(locations)
    StatTracker.new(locations[:games], locations[:teams], locations[:game_teams])
  end

  def list_team_ids
    @team_csv.map { |row| row[:team_id] }
  end

  def list_team_names_by_id(id)
    @team_csv.each { |row| return row[:teamname] if id.to_s == row[:team_id] }
  end

  def highest_total_score
    @game_csv.map { |row| row[:away_goals].to_i + row[:home_goals].to_i }.max
  end

  def lowest_total_score
    @game_csv.map { |row| row[:away_goals].to_i + row[:home_goals].to_i }.min
  end

  def count_of_teams
    @team_csv.count { |row| row[:team_id] }
  end


  def best_offense
    best ave goals over all seasons...
    #@game.csv.map { |row| row[:away_goals].max + row[:home_goals].max }.sum
   # create a hash with each teams scores.by max?
   #  scores = @game_path.map do |row|
   #  row[:away_goals].to_i + row[:home_goals].to_i
   #  end
   # scores.max

   #the team with the highest averages goals per game per season
   #@game_path.each  { |row| row[:away_goals] + row[:home_goals] }.sum

   # best = average_goals.max_by {|key,value| value}
   #the team with the highest averages goals per game per season
 end


end
