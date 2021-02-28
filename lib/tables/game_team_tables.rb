require './lib/helper_modules/csv_to_hashable'
require './lib/instances/game_team'

class GameTeamTable
  include CsvToHash
  attr_reader :game_team_data, :teams, :stat_tracker
  def initialize(locations, stat_tracker)
    @game_team_data = from_csv(locations, 'GameTeam')
    @stat_tracker = stat_tracker
  end

  def winningest_coach(season)
    
    season = @stat_tracker.game_by_season[season.to_i].map do |season|
      season.game_id
    end
   
    ids = @game_team_data.map do |gameteam|
      gameteam.game_id
    end

    overlap = season & ids

    games_by_season= @game_team_data.find_all do |games|
      overlap.include?(games.game_id)
    end

    winning_coach_hash =games_by_season.group_by do |game|
       game.head_coach if game.result == "WIN"
      end  

    win_count = winning_coach_hash.each { |k, v| winning_coach_hash[k] = v.count}.reject{|coach| coach == nil}
    # require 'pry'; binding.pry
    win_count.max_by{|coach, win| win}[0]

  end
end
