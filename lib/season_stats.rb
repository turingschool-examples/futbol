require 'csv'
require 'team'

class SeasonStats
  attr_reader :teams, :game_teams
  
  def initialize
    @teams = CSV.open('./data/teams.csv', headers: true, header_converters: :symbol).map { |row| Team.new(row) }
    @game_teams = CSV.open('./data/game_teams.csv', headers: true, header_converters: :symbol).map { |row| GameTeams.new(row) }
  end

  def winningest_coach(season_year)
    total_game_hash = Hash.new(0)
    win_coach_hash = Hash.new(0)
    @game_teams.each do |game|
      if game.season_id == season_year
        total_game_hash[game.coach] += 1
        win_coach_hash[game.coach] = 0 
      end
    end
    @game_teams.each do |game|
      if game.season_id == season_year
        if game.result == "WIN"
          win_coach_hash[game.coach] += 1
        end
      end
    end
    total_game_hash.merge!(win_coach_hash) {|coach, games, wins| wins.to_f / games}
    total_game_hash.key(total_game_hash.values.max)
  end

end

