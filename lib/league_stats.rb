require './lib/initiable'

class LeagueStats
  include Initiable

  def self.from_csv_paths(file_paths)
    files = {
    game_csv: CSV.read(file_paths[:game_csv], headers: true, header_converters: :symbol),
    gameteam_csv: CSV.read(file_paths[:gameteam_csv], headers: true, header_converters: :symbol),
    team_csv:CSV.read(file_paths[:team_csv], headers: true, header_converters: :symbol)
    }
    LeagueStats.new(files)
  end

  def self.count_of_teams
    return @@all_teams.length
  end

  def self.best_offense
    team_offense = Hash.new(0)
    games_played = Hash.new(0)
    @@all_game_teams.each { |row| team_offense[row[:team_id]] += row[:goals].to_f
    games_played[row[:team_id]] += 1 }
    best_offense_team = team_offense.merge(games_played) { |_, goals, games_played| goals/games_played }
    teamid = best_offense_team.max_by { |_, percent| percent }.first
    @@all_teams.each { |row| return row[:teamname] if row[:team_id] == teamid }
  end

  def self.worst_offense
    team_offense = Hash.new(0)
    games_played = Hash.new(0)
    @@all_game_teams.each { |row| team_offense[row[:team_id]] += row[:goals].to_f
    games_played[row[:team_id]] += 1 }
    worst_offense_team = team_offense.merge(games_played) { |_, goals, games_played| goals / games_played }
    teamid = worst_offense_team.min_by { |_, percent| percent }.first
    @@all_teams.each { |row| return row[:teamname] if row[:team_id] == teamid }
  end

  def self.highest_scoring_visitor
    team_offense = Hash.new(0)
    games = Hash.new(0)
    @@all_games.each { |row| team_offense[row[:away_team_id]] += row[:away_goals].to_f
    games[row[:away_team_id]] += 1 }
    highest_scoring_visitor = team_offense.merge(games) { |_, away_goals, games| away_goals/games }
    teamid = highest_scoring_visitor.max_by { |_, percent| percent }.first
    @@all_teams.each { |row| return row[:teamname] if row[:team_id] == teamid }
  end

  def self.highest_scoring_home_team
    team_offense = Hash.new(0)
    games = Hash.new(0)
    @@all_games.each { |row| team_offense[row[:home_team_id]] += row[:home_goals].to_f
      games[row[:home_team_id]] += 1 }
    highest_scoring_home_team = team_offense.merge(games) { |_, home_goals, games| home_goals / games }
    teamid = highest_scoring_home_team.max_by { |_, percent| percent }.first
    @@all_teams.each { |row| return row[:teamname] if row[:team_id] == teamid }
  end

  def self.lowest_scoring_visitor
    team_offense = Hash.new(0)
    games = Hash.new(0)
    @@all_games.each { |row| team_offense[row[:away_team_id]] += row[:away_goals].to_f
      games[row[:away_team_id]] += 1 }
    lowest_scoring_visitor = team_offense.merge(games) { |_, away_goals, games| away_goals / games }
    teamid = lowest_scoring_visitor.min_by { |_, percent| percent }.first
    @@all_teams.each { |row| return row[:teamname] if row[:team_id] == teamid }
  end

  def self.lowest_scoring_home_team
    team_offense = Hash.new(0)
    games = Hash.new(0)
    @@all_games.each { |row| team_offense[row[:home_team_id]] += row[:home_goals].to_f
    games[row[:home_team_id]] += 1 }
    lowest_scoring_home_team = team_offense.merge(games) { |_, home_goals, games| home_goals / games }
    teamid = lowest_scoring_home_team.min_by { |_, percent| percent }.first
    @@all_teams.each { |row| return row[:teamname] if row[:team_id] == teamid }
  end
end
