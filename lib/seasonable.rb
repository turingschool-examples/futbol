module Seasonable

  def all_games_by_season
    @all_games_by_season ||= @games.group_by { |game| game.season } 
  end

  def team_name(id)
    @teams.each do |team|
        return team.team_name if team.team_id == id 
    end
  end

end