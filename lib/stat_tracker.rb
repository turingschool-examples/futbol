require 'CSV'
require './lib/team'

class StatTracker

  def initialize
    @teams = []
    @games = []
    load_from_csv
  end

# team_id,franchiseId,teamName,abbreviation,Stadium,link

  def load_from_csv
    CSV.foreach('./data/teams.csv', headers: true, header_converters: :symbol) do |row|
      data = {team_id: row[:id],
              franchiseid: row[:franchiseid],
              teamname: row[:teamname],
              abbreviation: row[:abbreviation],
              stadium: row[:stadium],
              link: row[:link]
            }
      @teams << Team.new(data)
    end

    CSV.foreach('./data/games.csv', headers: true, header_converters: :symbol) do |row|
      #adapt symbols to wahtever is the header in games.csv
      data = {team_id: row[:id],
              franchiseid: row[:franchiseid],
              teamname: row[:teamname],
              abbreviation: row[:abbreviation],
              stadium: row[:stadium],
              link: row[:link]
            }
      @games << Game.new(data)
    end
  end

  def count_of_teams
    @teams.size
  end
end
