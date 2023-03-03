require 'csv' 
require_relative 'team'
require_relative 'game'
require_relative 'game_teams'



class StatTracker
  attr_reader :game_stats,
              :team_stats,
              :season_stats

  def self.from_csv(files)
   StatTracker.new(files)
  end

  def initialize(files)
    @game_stats = GameStats.new(files)
    @team_stats = TeamStats.new(files)
    @season_stats = SeasonStats.new(files)
  end

  # Game Stats
    # def highest_total_score
      # @game_stats.highest_total_score
    #end


  # League Stats
  # Season Stats

end