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


  #Name of the team with the highest average number of goals scored per game across all seasons.
  def best_offense
    team_offense = Hash.new(0)
    games_played = Hash.new(0)
    @game_teams_csv.each do |row|
      team_offense[row[:team_id]] += row[:goals].to_f
      games_played[row[:team_id]] += 1
    end
    best_offense_team = Hash.new
    best_offense_team = team_offense.merge(games_played) { |team, goals, games_played| goals/games_played }
    teamid = best_offense_team.max_by { |team, percent| percent }.first
    @team_csv.each do |row|
      return row[:teamname] if row[:team_id] == teamid
     end
  end
#Name of the team with the lowest average number of goals scored per game across all seasons.
  def worst_offense
    team_offense = Hash.new(0)
    games_played = Hash.new(0)
    @game_teams_csv.each do |row|
      team_offense[row[:team_id]] += row[:goals].to_f
      games_played[row[:team_id]] += 1
    end
    worst_offense_team = Hash.new
    worst_offense_team = team_offense.merge(games_played) { |team, goals, games_played| goals/games_played }
    teamid = worst_offense_team.min_by { |_, percent| percent }.first
    @team_csv.each do |row|
      return row[:teamname] if row[:team_id] == teamid
     end
   end
  #Name of the team with the lowest average number of goals scored per game across all seasons. FC Dallas
   def highest_scoring_visitor
     team_offense = Hash.new(0)
     games = Hash.new(0)
     @game_csv.each do |row|
       team_offense[row[:away_team_id]] += row[:away_goals].to_f
       games[row[:away_team_id]] += 1
     end
     highest_scoring_visitor = Hash.new
     highest_scoring_visitor = team_offense.merge(games) { |team, away_goals, games| away_goals/games }
     teamid = highest_scoring_visitor.max_by { |_, percent| percent }.first
     @team_csv.each do |row|
       return row[:teamname] if row[:team_id] == teamid
      end
    end
    # returns the highest_scoring_home_team'
    def highest_scoring_home_team
      team_offense = Hash.new(0)
      games = Hash.new(0)
      @game_csv.each do |row|
        team_offense[row[:home_team_id]] += row[:home_goals].to_f
        games[row[:home_team_id]] += 1
      end
      highest_scoring_home_team = Hash.new
      highest_scoring_home_team = team_offense.merge(games) { |team,home_goals, games| home_goals/games }
      teamid = highest_scoring_home_team.max_by { |_, percent| percent }.first
      @team_csv.each do |row|
        return row[:teamname] if row[:team_id] == teamid
       end
     end
    #returns the lowest_scoring_visitor
    def lowest_scoring_visitor
      team_offense = Hash.new(0)
      games = Hash.new(0)
      @game_csv.each do |row|
        team_offense[row[:away_team_id]] += row[:away_goals].to_f
        games[row[:away_team_id]] += 1
      end
      lowest_scoring_visitor = Hash.new
      lowest_scoring_visitor = team_offense.merge(games) { |team, away_goals, games| away_goals/games }
      teamid = lowest_scoring_visitor.min_by { |_, percent| percent }.first
      @team_csv.each do |row|
        return row[:teamname] if row[:team_id] == teamid
       end
     end

    #returns the lowest_scoring_home_team
    def lowest_scoring_home_team
      team_offense = Hash.new(0)
      games = Hash.new(0)
      @game_csv.each do |row|
        team_offense[row[:home_team_id]] += row[:home_goals].to_f
        games[row[:home_team_id]] += 1
      end
      lowest_scoring_home_team = Hash.new
      lowest_scoring_home_team = team_offense.merge(games) { |team,home_goals, games| home_goals/games }
      teamid = lowest_scoring_home_team.min_by { |_, percent| percent }.first
      @team_csv.each do |row|
        return row[:teamname] if row[:team_id] == teamid
       end
     end








end
