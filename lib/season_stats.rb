require_relative "futbol"

class SeasonStats < Futbol

  def initialize(locations)
    super(locations)
  end

  def most_accurate_team(season)
    return invalid_season if season_no_existy?(@games.season)
    team = @teams.select do |team|
      team.team_id == 
    end
  end



  def least_accurate_team

  end

  def season_no_existy?(season)
    seasons = 
  end

  def invalid_season
    'Season does not exist'
  end

end
