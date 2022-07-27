require_relative './teams'
require_relative './game'
require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams,
              :game_path,
              :team_path,
              :game_teams_path,
              :locations

  def initialize(games, teams, game_teams)
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }
    @games = Game.create_multiple_games(@locations[:games])
    @teams = Teams.create_multiple_teams(@locations[:teams])
    @game_teams = GameTeams.create_multiple_game_teams(@locations[:game_teams])
  end


  def self.from_csv(locations)
    @games
    @teams
    @game_teams
    StatTracker.new(@games, @teams, @game_teams)
  end

  def highest_total_score
    high_low_added = @games.map do |game|
      [game.home_goals.to_i,game.away_goals.to_i].sum
    end
    high_low_added.max
  end

  def winningest_coach(season_id)

    coaches = []
    win_or_loss = []
    @game_teams.each do |game|
  require 'pry'; binding.pry
      if game.game_id == season_id
      coaches << game.head_coach
      win_or_loss << game.result

    end
    end
    result = coaches.zip(win_or_loss)
    result
      require 'pry'; binding.pry

    #find winning percentage of each coach then take max
    #games won/games played per coach
    #Best winning rate = winnigest coach
    #worst winning rate = worst coach
    game_wins = {}
    total_games = {}

    winning_rate = {}
    game_wins/total_games
  end

  def worst_coach
    #find winning percentage then take min
  end



end
