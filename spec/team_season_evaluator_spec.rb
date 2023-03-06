require './lib/team_season_evaluator'
require './lib/stat_tracker'

RSpec.describe TeamSeasonEvaluator do
  before(:each) do 
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
  
      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
  
      @stat_tracker = StatTracker.from_csv(locations)
  end

  it "delivers the same result as the non-modularized version of #best_season" do
    expect(@stat_tracker.best_season("6")).to eq "20132014"
  end
end