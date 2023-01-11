module Groupable 
    def games_by_game_id
    @games_by_game_id ||= @game_teams_path.group_by do |row| 
      row[:game_id]
    end
  end

  def games_by_season
    @games_by_season ||= @game_path.group_by do |row|
      row[:season] 
    end
  end

   def teams_by_id
    @game_teams_path.group_by do |row|
      row[:team_id]
    end
  end

  def games_by_id_game_path
    @games_by_id_game_path ||= @game_path.group_by do |row|
      row[:game_id]
    end
  end

  def games_by_team_id # TEAM Class
    @games_by_team_id ||= @game_teams_path.group_by do |row|
      row[:team_id]
    end
  end
end