module LeagueSearchable

	def team_ids
                teams.map(&:team_id)
        end


        def games_between_teams(id, opp_id)
                games_to_return = []
                Game.all.each do |game|
                                if (game.home_team_id == id || game.away_team>
                                        if (game.home_team_id == opp_id || ga>
                                                games_to_return << game
                                        end
                                end
                end
                simplify_games_between_teams(id, games_to_return)
        end

	 def simplify_games_between_teams(id, games)
                updated_games = []
                games.map do |game|
                        game_holder = []
                        if game.home_team_id == id
                                game_holder << game.id
                                game_holder << game.away_team_id
                                game_holder << game.home_goals
                                game_holder << game.away_goals
                                updated_games << game_holder
                        elsif game.away_team_id == id
                                game_holder << game.id
                                game_holder << game.home_team_id
                                game_holder << game.away_goals
                                game_holder << game.home_goals
                                updated_games << game_holder
                        end
                end
                updated_games = updated_games.uniq
                updated_games.map {|game| game.delete_at(0)}
                updated_games
        end

	def games_for_team(id)
                loop_teams = team_ids
                loop_teams.delete(id)
                games_to_return = []
                loop_teams.map do |opp_team|
                        binding.pry
                        games_to_return << games_between_teams(id, opp_team)
                end
                games_to_return.reject(&:empty?)
        end
