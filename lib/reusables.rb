
module Reuseable

 def team_by_id
   @teams.values_at(:team_id, :teamname).uniq.to_h
  end

  def coaches_by_id
 
  end

  def games_in_season

  end

end