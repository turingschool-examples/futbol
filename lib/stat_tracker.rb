require_relative './teams'
require_relative './game'
require_relative './game_teams'
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

  def team_info(team_id)
    team_hash = Hash.new(0)
    @teams.each do |team|
      if team_id == team.team_id
        team_hash["team_id"] = team.team_id
        team_hash["franchise_id"] = team.franchise_id
        team_hash["team_name"] = team.team_name
        team_hash["abbreviation"] = team.abbreviation
        team_hash["link"] = team.link
      end
    end
    team_hash
  end

end
