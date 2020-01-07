require 'pry'
module SeasonSearchable

  def best_season(team_id)
    team = teams.find {|team| team.team_id.to_s == team_id}
    binding.pry
    season_wins = team.stats_by_season.reduce({}) do |acc, (season, values)|
      # binding.pry
      if (values[:postseason][:win_percentage] > 0)
        binding.pry
      acc[season] = ((values[:regular_season][:win_percentage] + values[:postseason][:win_percentage]) / 2).round(2)
      else
        binding.pry
      acc[season] = (values[:regular_season][:win_percentage])
      end
    acc
    end
    binding.pry
    return season_wins.max_by{|season, win_percentage| win_percentage}.first
  end

  def worst_season(team_id)
    team = teams.find {|team| team.team_id.to_s == team_id}
    binding.pry
    season_wins = team.stats_by_season.reduce({}) do |acc, (season, values)|
      # binding.pry
      if (values[:postseason][:win_percentage] > 0)
        binding.pry
      acc[season] = ((values[:regular_season][:win_percentage] + values[:postseason][:win_percentage]) / 2).round(2)
      else
        binding.pry
      acc[season] = (values[:regular_season][:win_percentage])
      end
    acc
    end
    binding.pry
    return season_wins.min_by{|season, win_percentage| win_percentage}.first
  end
end
