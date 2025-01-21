require_relative './csv_helper'

class League_Statistics
@@teams = nil
@@game = nil
@@game_teams = nil

  def self.set_leagueCSV(teams, games, game_teams)
    @@teams = CSVHelper.teamsCSV(teams)
    @@games = CSVHelper.gamesCSV(games)
    @@game_teams = CSVHelper.game_teamsCSV(game_teams)
  end

  def self.count_of_teams
    @@teams.count
  end

  def self.best_offense
    teams_average_offense = self.average_offense

    best_offense_id = teams_average_offense.max_by { |team_id, average_goals| average_goals }[0]

    @@teams.select { |team| team.team_id == best_offense_id }[0].team_name
  end

  def self.worst_offense
    teams_average_offense = self.average_offense

    worst_offense_id = teams_average_offense.min_by { |team_id, average_goals| average_goals }[0]

    @@teams.select { |team| team.team_id == worst_offense_id }[0].team_name
  end

  def self.highest_scoring_visitor
    highest_visitor = goals(:away).max_by { |team_id, average_goals| average_goals}[0]

    @@teams.select { |team| team.team_id == highest_visitor }[0].team_name
  end

  def self.highest_scoring_home_team
    highest_home_team = goals(:home).max_by { |team_id, average_goals| average_goals}[0]

    @@teams.select { |team| team.team_id == highest_home_team }[0].team_name
  end

  def self.lowest_scoring_visitor
    lowest_visitor = goals(:away).min_by { |team_id, average_goals| average_goals}[0]

    @@teams.select { |team| team.team_id == lowest_visitor }[0].team_name
  end

  def self.lowest_scoring_home_team
    lowest_home_team = goals(:home).min_by { |team_id, average_goals| average_goals}[0]

    @@teams.select { |team| team.team_id == lowest_home_team }[0].team_name
  end

  def self.games_played(team_id)
    @@game_teams.find_all do |game_team|
      game_team.team_id == team_id
    end.count
  end

  private

  def self.average_offense
    games = team_games
    team_ids = StatsHelper.team_ids

    teams_offense = {}

    team_ids.each do |team_id|
      teams_offense[team_id] = games[team_id].sum { |game| game.goals } / (games[team_id].count).to_f
    end

    teams_offense
  end

  def self.team_games
    team_games = {}
    team_ids = StatsHelper.team_ids

    team_ids.each do |team_id|
      team_games[team_id] = []
    end

    @@game_teams.each do |team_game|
      team_games[team_game.team_id] << team_game
    end

    team_games
  end

  def self.home_or_away_games(home_or_away)
    games = {}
    team_ids = StatsHelper.team_ids

    team_ids.each do |team_id|
      games[team_id] = []
    end

    @@games.each do |game|
      if home_or_away == :home
        games[game.home_team_id] << game
      elsif home_or_away == :away
        games[game.away_team_id] << game
      end
    end

    games
  end

  def self.goals(home_or_away)

    team_ids = StatsHelper.team_ids
    games = home_or_away_games(home_or_away)
    goals = {}

    games.each do |game|

      if home_or_away == :home
        team_ids.each do |team_id|
          total_goals = games[team_id].sum { |game| game.home_goals}
          average_goals = total_goals.to_f / games[team_id].count
          goals[team_id] = average_goals
          
        end

      elsif home_or_away == :away
        team_ids.each do |team_id|
          total_goals = games[team_id].sum { |game| game.away_goals}
          average_goals = total_goals.to_f / games[team_id].count
          goals[team_id] = average_goals
        end
      end

    end
    goals
  end
end