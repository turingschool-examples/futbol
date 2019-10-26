require 'csv'
require_relative 'game_teams'

class GameTeamsCollection

  def initialize(game_teams_path)
    @game_teams_path = game_teams_path
    @game_teams_collection_instances = all_game_teams
  end

  def all_game_teams
    csv = CSV.read("#{@game_teams_path}", headers: true, header_converters: :symbol)
      csv.map do |row|
       GameTeams.new(row)
    end
  end

  def winningest_team
     #refactor for winningest
     team_game_count = Hash.new(0)
     @game_teams_collection_instances.each do |game|
       if game.result == "WIN"
       team_game_count[game.team_id] += 1
      end
     end
    winningest = team_game_count.max_by {|key, value| value}
  end
end
