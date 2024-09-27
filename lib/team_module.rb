require './required_files'

module TeamModule

  def TeamModule.season_hash(team_id, game_teams)
    game_team_arr = game_teams.find_all do |game|
      game.team_id == team_id
    end
    season_record_hash = {}
    game_team_arr.each do |game|
      if season_record_hash[game.game_id[0..3]] == nil
        season_record_hash[game.game_id[0..3]] = [game.result]
      else
        season_record_hash[game.game_id[0..3]] << game.result
      end
    end
    season_record_hash
  end

  def TeamModule.season_win_percentages(team_id, game_teams)
    season_record_hash = TeamModule.season_hash(team_id, game_teams)
    win_counter = 0
    season_win_percentage_hash = {}
    season_record_hash.each do |season, result|
       win_counter = result.count("WIN")
       win_percentage = (win_counter.to_f / result.count.to_f) * 100
       season_win_percentage_hash[season] = win_percentage
     end
     season_win_percentage_hash
   end
 end
