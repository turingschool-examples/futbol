

class SeasonTracker < Statistics

  def winningest_coach(season_id)
    seasons = @games.find_all {|game| game.season == season_id}
    seasons.each do |game|
      @game_teams.find_all do |game_2|
        game.game_id == game_2.game_id
      end
    end
    coaches = @game_teams.group_by do |game|
      game.head_coach
    end
    hash = Hash.new
    coaches.each_pair do |coach, games|
      result = games.count do |game|
        game.result == "WIN"
      end
      hash[coach] = result.to_f / coaches[coach].length
    end
    hash.key(hash.values.max)
  end




end
