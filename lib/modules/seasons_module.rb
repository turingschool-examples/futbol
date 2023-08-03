require './lib/helper_class'

module Seasons
  def Season.best_offense
    require 'pry';binding.pry
    combined_games = Season.seasons.group_by { |game| team[:game_id] }
  end
end