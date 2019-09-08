module GenerateData

  def generate_data
    info = {}
    @game_teams.each do |team_id, game_objs|
      game_objs.each do |game_obj|
        if info.has_key?(game_obj.team_id)
          info[game_obj.team_id] <<
          {
            game_id: game_obj.game_id,
            hoa: game_obj.hoa,
            shots: game_obj.shots,
            goals: game_obj.goals,
            result: game_obj.result,
            tackles: game_obj.tackles,
            season: @games[game_obj.game_id].season,
            opponent: @games[game_obj.game_id].away_team_id,
            opponent_goals: @games[game_obj.game_id].away_goals,
          }
        else
          info[game_obj.team_id] =
          [{
            game_id: game_obj.game_id,
            hoa: game_obj.hoa,
            shots: game_obj.shots,
            goals: game_obj.goals,
            result: game_obj.result,
            tackles: game_obj.tackles,
            season: @games[game_obj.game_id].season,
            opponent: @games[game_obj.game_id].away_team_id,
            opponent_goals: @games[game_obj.game_id].away_goals,
          }]
        end 

      end
    end
    info
  end

end
