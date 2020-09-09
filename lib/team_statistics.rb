module TeamStatistics

  def team_info(team_id)
    team_info = {}
    team = @team_table.fetch(team_id)
    team.instance_variables.each do |instance_variable|
      team_info[instance_variable.to_s.delete(":@")] = team.instance_variable_get(instance_variable)
    end
    team_info.delete("stadium")
    team_info
  end
# hash with season with all games pplayed by team.
  def collect_seasons(team_id)
    season_game_id_hash = {}
        @game_table.each do |game_id, game|
          if  season_game_id_hash[game.season].nil? && (team_id.to_i == game.away_team_id || team_id.to_i == game.home_team_id)
             season_game_id_hash[game.season] = [game]
           elsif team_id == game.away_team_id || team_id.to_i == game.home_team_id
             season_game_id_hash[game.season] << game
           end
        end
        collect_wins_per_season(team_id, season_game_id_hash)
  end

  def collect_wins_per_season(team_id, season_game_id_hash)
    wins = 0
    season_game_id_hash.each do |season|
      season[1].each do |game|
        if (team_id.to_i) == game.away_team_id && (game.away_goals > game.home_goals)
          wins += 1
        elsif (team_id.to_i) == game.home_team_id && (game.away_goals < game.home_goals)
          wins += 1
        end
      end
      require "pry"; binding.pry
    end
  end

  # seasons = {}
  # @game_table.each do |key, value|
  #   if value.away_team_id == team_id || value.home_team_id == team_id
  #
  # end
  # require "pry"; binding.pry
  #   def find_all_seasons
  #   seasons = []
  #   @csv_games_table.each do |game_id, game|
  #     if !seasons.include?(game.season)
  #       seasons << game.season
  #     end
  #   end
  #   seasons
  # end
  # def map_season_to_game_ids
  #     season_game_id_hash = {}
  #     @csv_games_table.each do |game_id, game|
  #         season_game_id_hash[game_id] = game.season
  #     end
  #     season_game_id_hash
  #   end
  # @team_table.each do |team|
  # team_info = {}
  #   require "pry"; binding.pry
  #   if team_info[team[1].team_id].nil?
  #       team_info[team[1].team_id] = [team[1].abbreviation, team[1].franchiseId,
  #       team[1].link, team[1].team_id, team[1].team_name]
  #   end
  #   team_info
  # end

#   def total_games_played_per_season_by_team
#     hash = {}
#     @game_table.each do |game|
#       if hash[game[1].season].nil?
#           hash[game[1].season] = [game[1].home_team_id, game[1].away_team_id]
#       else
#         hash[game[1].season] << [game[1].home_team_id, game[1].away_team_id]
#       end
#     end
#     hash.each do |key, value|
#       value.flatten!
#     end
#     games_played_per_season = total_games_per_season(hash)
#     games_played_per_season
#   end
# # refactored to increase efficiency, 2x iterations.
#   def total_games_per_season(input)
#     season_hash = {}
#     new_hash = {}
#     input.each do |season|
#       season[1].each do |team_id|
#         if new_hash[team_id].nil?
#           new_hash[team_id]= season[1].count(team_id)
#         end
#       end
#       season_hash[season[0]] = new_hash
#       new_hash = {}
#     end
#     season_hash
#   end


end
