module Groupable 
    def games_by_game_id
    @games_by_game_id ||= @game_teams_path.group_by do |row| 
      row[:game_id]
    end
  end

  def create_hash 
    Hash.new{|k,v| k[v] = []}
  end
end