module TeamStats

  def favorite_opponent(team_id)
    opponent_id = opponent_stats(team_id).min_by do |tm_id, counts|
      counts[:wins] / counts[:games].to_f
    end[0]

    @teams[opponent_id].team_name
  end

  def rival(team_id)
    opponent_id = opponent_stats(team_id).min_by do |tm_id, counts|
      counts[:losses] / counts[:games].to_f
    end[0]

    @teams[opponent_id].team_name
  end

  def head_to_head(team_id)
    record = Hash.new
    opponent_stats = opponent_stats(team_id)

    opponent_stats.each do |tm_id, counts|
      record[@teams[tm_id].team_name] = (counts[:losses] / counts[:games].to_f).round(2)
    end

    record
  end

  # def seasonal_summary(team_id)
  #   team_id = team_id.to_i
  #   season_summary = Hash.new { Hash.new { |h,k| h[k] = Hash.new(0) } }
  #   opponent_stats = opponent_stats(team_id)
  #
  #   @seasons.each do |season|
  #     @games.each do |game_id, game|
  #       if game.season == season && game.type == "Postseason"
  #         # season_summary[season][:postseason]
  #       elsif game.season == season && game.type == "Regular Season"
  #         # season_summary[season][:regular_season]
  #       end
  #     end
  #   end
  #
  #   season_summary[]
  # end


end
