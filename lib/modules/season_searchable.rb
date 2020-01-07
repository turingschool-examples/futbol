require 'pry'
module SeasonSearchable

  def best_season(team_id)
     season_wins(team_id).max_by{|season, win_percentage| win_percentage}.first
  end

  def worst_season(team_id)
    season_wins(team_id).min_by{|season, win_percentage| win_percentage}.first
  end

  def average_win_percentage(team_id)
      win_array = season_wins(team_id).reduce([]) do |acc, (season, values)|
        acc << values
        acc
      end
    return (win_array.sum / win_array.length).round(2)
  end

  def season_wins(team_id)
    team = teams.find {|team| team.team_id.to_s == team_id}
    season_wins = team.stats_by_season.reduce({}) do |acc, (season, values)|
      if (values[:postseason][:win_percentage] > 0)
      acc[season] = ((values[:regular_season][:win_percentage] + values[:postseason][:win_percentage]) / 2).round(2)
      else
      acc[season] = (values[:regular_season][:win_percentage])
      end
    acc
    end
  end
end
