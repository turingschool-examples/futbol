require_relative './team'
require_relative './game'
require_relative './game_teams'
require 'csv'
class CsvHelper

def self.generate_team_array(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)

    teams_collection = csv.map do |row|
        # require"pry";binding.pry
        team = Team.new(row)
    end
    teams_collection
  end

  def self.generate_game_array(file_path)
      csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
      game_collection = csv.map do |row|
        #require 'pry'; binding.pry
        game = Game.new(row)
         # require 'pry'; binding.pry
      end
      game_collection
  end

  def self.generate_game_teams_array(file_path)

    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
    game_team_collection = csv.map do |row|
      game_teams = GameTeams.new(row)

    end
    game_team_collection

end


end
