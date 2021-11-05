require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize (games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = []
    CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
      game = Game.new(row)
      games << game
    end
    teams = []
    CSV.foreach(locations[:teams], headers: true, header_converters: :symbol) do |row|
      team = Team.new(row)
      teams << team
    end
    game_teams = []
    CSV.foreach(locations[:game_teams], headers: true, header_converters: :symbol) do |row|
      game_team = GameTeam.new(row)
      game_teams << game_team
    end

    stat_tracker = StatTracker.new(games, teams, game_teams)
  end
  # Game Statistics
  def highest_total_score
    high_score = 0
    @games.each_value do |game|
      high = game.away_goals + game.home_goals
      if (game.away_goals + game.home_goals) > high_score
        high_score = game.away_goals + game.home_goals
      end
    end
    high_score
  end
  # League Statistics


  # Season Statistics


  # Team Statistics
  def team_info(team_id)
    team = @teams.find { |team| team.team_id == team_id }
    # team = result[0]

    info = {
      :team_id => team.team_id,
      :franchise_id => team.franchise_id,
      :team_name => team.team_name,
      :abbreviation => team.abbreviation,
      :link => team.link
    }
  end

  def best_season(team_id)

    game_ids = []
    won_game_ids = []
    total_by_season = Hash.new(0)
    wins_by_season = Hash.new(0)
    percent_by_season = Hash.new(0)

    games = @game_teams.select { |game_team| game_team.team_id == team_id }

    game_ids = games.map { |game| game.game_id }

    game_ids.each do |id|
      @game_teams.each do |game|
        if id == game.game_id
          if game.result == "WIN"
            won_game_ids << id
          end
        end
      end
    end

    game_ids.each do |id|
      @games.each do |game|
        if game.game_id == id.slice(0..9).to_i
          total_by_season[game.season] += 1
        end
      end
    end

    won_game_ids.each do |id|
      @games.each do |game|
        if game.game_id == id.slice(0..9).to_i
          wins_by_season[game.season] += 1
        end
      end
    end

    total_by_season.each_key do |key|
      percent_by_season[key] = wins_by_season[key] * 100 / total_by_season[key].to_f
    end

    max_season = percent_by_season.max_by { |key,value| value }[0]

  end

  def worst_season(team_id)

    game_ids = []
    won_game_ids = []
    total_by_season = Hash.new(0)
    wins_by_season = Hash.new(0)
    percent_by_season = Hash.new(0)

    games = @game_teams.select { |game_team| game_team.team_id == team_id }

    game_ids = games.map { |game| game.game_id }

    game_ids.each do |id|
      @game_teams.each do |game|
        if id == game.game_id
          if game.result == "WIN"
            won_game_ids << id
          end
        end
      end
    end

    game_ids.each do |id|
      @games.each do |game|
        if game.game_id == id.slice(0..9).to_i
          total_by_season[game.season] += 1
        end
      end
    end


    won_game_ids.each do |id|
      @games.each do |game|
        if game.game_id == id.slice(0..9).to_i
          wins_by_season[game.season] += 1
        end
      end
    end

    total_by_season.each_key do |key|
      percent_by_season[key] = wins_by_season[key] * 100 / total_by_season[key].to_f
    end

    max_season = percent_by_season.min_by { |key,value| value }[0]

  end

  def average_win_percentage(team_id)
    total_games = @game_teams.select { |game_team| game_team.team_id == team_id }

    total_wins = total_games.select { |game| game.result == "WIN" }

    (total_wins.count.to_f / total_games.count.to_f * 100).round(2)
  end

  def most_goals_scored(team_id)
    total_games = @game_teams.select { |game_team| game_team.team_id == team_id }

    game = total_games.max_by { |game| game.goals }

    game.goals
  end

  def fewest_goals_scored(team_id)
    total_games = @game_teams.select { |game_team| game_team.team_id == team_id }

    game = total_games.min_by { |game| game.goals }
    
    game.goals
  end


end
