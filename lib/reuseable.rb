
module Reuseable

 def team_by_id
   @teams.values_at(:team_id, :teamname).uniq.to_h
  end

  def coach_by_team_id #Provides hash of coach names by team id - Helper method for issue #27
    # Example hash: {3=>"John Tortorella", 6=>"Claude Julien",  5=>"Dan Bylsma",
    coaches = Hash.new {|h, k| h[k] = {}}
    games_by_season.each do |season, games|
      @game_teams.each do |row|
        if games.include?(row[:game_id])
          if !coaches[row[:team_id]].keys.include?(season)
            coaches[row[:team_id]][season] = [row[:head_coach]]
          elsif !coaches[row[:team_id]][season].include?(row[:head_coach])
            coaches[row[:team_id]][season] << row[:head_coach]
          end
        end
      end
    end
    coaches
  end

  def games_in_season

  end

end