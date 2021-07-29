require 'spec_helper'

RSpec.describe StatTracker do
  before(:each) do

    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_sample.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it "exists" do
    expect(@stat_tracker).to be_a(StatTracker)
  end

  # xit "counts teams" do
  #   expect(@stat_tracker.count_of_teams).to eq(32)
  # end
  #
  # xit "calculates team with highest avg. goals/game all seasons" do
  #
  #
  # end
end




# best_offense	Name of the team with the highest average number of goals scored per game across all seasons.	String
# worst_offense	Name of the team with the lowest average number of goals scored per game across all seasons.	String
# highest_scoring_visitor	Name of the team with the highest average score per game across all seasons when they are away.	String
# highest_scoring_home_team	Name of the team with the highest average score per game across all seasons when they are home.	String
# lowest_scoring_visitor	Name of the team with the lowest average score per game across all seasons when they are a visitor.	String
# lowest_scoring_home_team	Name of the team with the lowest average score per game across all seasons when they are at home.	String


# stat_tracker = StatTracker.get_csv(locations)
# p stat_tracker.find_team_by_id('3')
# p stat_tracker.games_by_season
# p stat_tracker.total_game_score_array
