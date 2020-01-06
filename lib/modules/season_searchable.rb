require 'pry'
module SeasonSearchable

  def best_season(team_id)
    winning_season = 0
    team = teams.find {|team| team.team_id == team_id}
    binding.pry
    team.stats_by_season.each do |season|
      binding.pry
      # stat_tracker.teams[team].stats_by_season[season][reg_season][win_percentage]
    end
  end

end
