require './lib/stat_tracker'
require './lib/game_manager'
require './lib/game_teams_manager'
require './lib/game_teams'
require './lib/games'
require './lib/teams_manager'
require './lib/teams'
RSpec.describe StatTracker do
  it 'exists' do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
              games: game_path,
              teams: team_path,
              game_teams: game_teams_path
                }

    stat_tracker = StatTracker.from_csv(locations)

    expect(stat_tracker).to be_an_instance_of(StatTracker)
  end

  xit '#highest_total_score' do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    locations = {
              games: game_path,
              teams: team_path,
              game_teams: game_teams_path
                }

    stat_tracker = StatTracker.from_csv(locations)

    expect(stat_tracker.highest_total_score).to eq(11)

  end

  it "caluculates average win percentage" do
    game_teams_path = './data/game_teams.csv'
    game_teams_manager = GameTeamsManager.new(game_teams_path)
    expect(game_teams_manager.average_win_percentage(6)).to eq(0.49)
  end
end
