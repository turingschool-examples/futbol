require './lib/game'
require './lib/team'
require './lib/game_team'
require 'csv'


class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(stat_tracker_params)
    games_path = stat_tracker_params[:games]
    teams_path = stat_tracker_params[:teams]
    game_teams_path = stat_tracker_params[:game_teams]

    @games = get_csv(games_path, Game) # Maybe ||= could prevent edge cases by assigning
    @teams = get_csv(teams_path, Team) # from the .csv if @games does not yet exist
    @game_teams = get_csv(game_teams_path, GameTeam)
  end

  def self.get_csv(stat_tracker_params)
    StatTracker.new(stat_tracker_params)
  end

  def find_team_by_id(id) # test method - feel free to delete
    @teams.find do |team|
      team.team_id == id
    end
  end

  def games_by_season # test method - feel free to delete
    @games.group_by { |game| game.season }
  end

  def total_game_score_array # test method - I'm not even sure this one's in the method list
  total_game_scores = []
  @games.each do |game|
    total_game_scores << game.total_game_score #using a method from game class
  end
  total_game_scores
  end
end


# maybe put all the stuff below in another file? module? idk

def get_csv(path, class_type)
  rows = CSV.read(path, headers: true, header_converters: :symbol)
  rows.map do |row|
    class_type.new(row)
  end
end

game_path = './data/games_sample.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}


# my examples
stat_tracker = StatTracker.get_csv(locations)
# require "pry"; binding.pry
# p stat_tracker.find_team_by_id('3')
# p stat_tracker.games_by_season
p stat_tracker.total_game_score_array
