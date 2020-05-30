require_relative './game'
require_relative './team'
require_relative './game_teams'
require 'csv'
require 'pry'

class GameTeamsCollection
  attr_reader :game_teams_collection

  def initialize(game_teams_collection)
    @game_teams_collection = game_teams_collection
  end

  def all
    all_game_teams = []
    CSV.read('./data/game_teams_fixture.csv', headers: true, header_converters: :symbol).each do |game_team|
      game_teams_hash = {game_id: game_team[:game_id], team_id: game_team[:team_id], hoa: game_team[:hoa], result: game_team[:result], settled_in: game_team[:settled_in], head_coach: game_team[:head_coach], goals: game_team[:goals], shots: game_team[:shots], tackles: game_team[:tackles], pim: game_team[:pim], powerplayopportunities: game_team[:powerplayopportunities], powerplaygoals: game_team[:powerplaygoals], faceoffwinpercentage: game_team[:faceoffwinpercentage], giveaways: game_team[:giveaways], takeaways: game_team[:takeaways]
        }
      all_game_teams << GameTeams.new(game_teams_hash)
    end
    all_game_teams
  end

end
