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
      data = {game_id: row[:game_id],
              season: row[:season],
              type: row[:type],
              date_time: row[:date_time],
              away_team_id: row[:away_team_id],
              home_team_id: row[:home_team_id],
              away_goals: row[:away_goals],
              home_goals: row[:home_goals],
              venue: row[:venue],
              venue_link: row[:venue_link]
            }
      @games << Game.new(data)
    end
  end

  def count_of_teams
    @teams.size
  end

  def best_offense
    @teams
  end
end
