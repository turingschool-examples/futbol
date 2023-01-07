module Sort

	def sort_objects_by(array_of_objects, header)
		array_of_objects.group_by do |object|
			object.info[header]
		end
	end
	
	def games_played_by_season(array_of_games)
		array_of_games.group_by do |game|
			game.info[:season]
		end
  end

	def games_by_game_id
		@games_by_game_id ||= @game_teams.group_by do |row|
			row.info[:game_id]
		end
	end

	def find_team_by_id
		@find_team_by_id ||= @teams.group_by do |row|
			row.info[:team_id]
		end
	end

	def team_name_by_id(id)
		find_team_by_id[id].first.info[:team_name]
	end

end