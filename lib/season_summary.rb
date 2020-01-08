require 'sorters'

module SeasonSummary
  include Sorters

  def season_summary(type, teamid)
    # season_ids = sort_what_by(teamid, season.uniq) #find all season codes per team and use as keys to loop how many times to do this
    season_totals = {}
    season_totals[:win_percentage] = "foo" #where to find info?
    season_totals[:total_goals_scored] = "foo" #where to find info?
    season_totals[:total_goals_against] = "foo" #where to find info?
    season_totals[:average_goals_scored] = "foo" #where to find info?
    season_totals[:average_goals_against] = "foo" #where to find info?
    season_totals
    # require "pry"; binding.pry
  end

end
