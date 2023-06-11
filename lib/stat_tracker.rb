require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class StatTracker
  attr_reader :games, :teams, :game_teams, :seasons, :league

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(data)
    @games = game_init(data)
    @teams = teams_init(data)
    @game_teams = game_teams_init(data)
    # @seasons = Season.new(@games)           # Might use later, not yet implemented
    # @league = League.new(@teams, @games)    # Might use later, not yet implemented
    # @game_stats = GameStats.new(@teams)     # Might use later, not yet implemented
  end

  def game_init(data)
    CSV.read(data[:games], headers: true, header_converters: :symbol).map { |row| Game.new(row) }
  end

  def teams_init(data)
    CSV.read(data[:teams], headers: true, header_converters: :symbol).map { |row| Team.new(row) }
  end

  def game_teams_init(data)
    CSV.read(data[:game_teams], headers: true, header_converters: :symbol).map { |row| GameTeam.new(row) }
  end

  # GAME STATS

  def highest_total_score
    output = @games.max do |game1, game2|
      (game1.away_goals + game1.home_goals) <=> (game2.away_goals + game2.home_goals)
    end
    output.away_goals + output.home_goals
  end

  def home_win?
    @games.count { |game| game.home_goals > game.away_goals }
  end

  def percentage_home_wins
    (home_win?.to_f / @games.size).round(2)
  end

  def away_win?
    @games.count { |game| game.away_goals > game.home_goals }
  end

  def percentage_visitor_wins
    (away_win?.to_f / @games.size).round(2)
  end

  # LEAGUE STATS

  def count_of_teams
    @teams.count
  end

  # SEASON STATS
  def winningest_coach(season_id)
    season_games = @games.select { |game| game.season_id == season_id }
    season_game_ids = season_games.map(&:game_id)

    # Filter game_teams by season_game_ids
    season_game_teams = @game_teams.select { |game_team| season_game_ids.include?(game_team.game_id) }

    coach_wins = Hash.new(0)
    coach_games = Hash.new(0)

    season_game_teams.each do |game_team|
      coach_games[game_team.coach] += 1
      coach_wins[game_team.coach] += 1 if game_team.game_result == 'WIN'
    end

    win_percentages = coach_wins.each_with_object({}) do |(coach, wins), percentages|
      percentages[coach] = wins.to_f / coach_games[coach]
    end

    win_percentages.max_by { |_, percentage| percentage }.first
  end

  def worst_coach(season_id)
    season_games = @games.select { |game| game.season_id == season_id }
    season_game_ids = season_games.map(&:game_id)

    # Filter game_teams by season_game_ids
    season_game_teams = @game_teams.select { |game_team| season_game_ids.include?(game_team.game_id) }

    coach_wins = Hash.new(0)
    coach_games = Hash.new(0)

    season_game_teams.each do |game_team|
      coach_games[game_team.coach] += 1
      coach_wins[game_team.coach] += 1 if game_team.game_result == 'WIN'
    end

    worst_win_percentage = 1.0
    worst_coach = ''

    coach_games.each do |coach, games|
      win_percentage = coach_wins[coach].to_f / games
      if win_percentage < worst_win_percentage
        worst_win_percentage = win_percentage
        worst_coach = coach
      end
    end

    worst_coach
  end

  def lowest_total_score
    output = @games.min do |game1, game2|
      (game1.away_goals + game1.home_goals) <=> (game2.away_goals + game2.home_goals)
    end
    return output.away_goals + output.home_goals
  end


  #league_stats

  #season_stats
end
