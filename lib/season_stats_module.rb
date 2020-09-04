module SeasonStatistics

  def coaches_and_game_id_hash
    coach_and_game = Hash.new
    @row.sort do |coach, game_id|
      coach_and_game[:coach] = :game_id
    end
  end


end
