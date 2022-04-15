require "pry"
require "rspec"
require "csv"
require "./lib/game_teams"
require "simplecov"
SimpleCov.start
require_relative "../lib/stat_tracker"

RSpec.describe GameTeams do
  before :each do
    game_path = "./data/games.csv"
    team_path = "./data/teams.csv"
    game_teams_path = "./data/game_teams.csv"

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'exists and has attributes' do
    expect(@stat_tracker.game_teams).to be_a GameTeams
    expect(@stat_tracker.game_teams.game_id).to eq (@stat_tracker[:game_teams][:game_id])
    expect(@stat_tracker.game_teams.team_id).to eq (@stat_tracker[:game_teams][:team_id])
    expect(@stat_tracker.game_teams.hoa).to eq (@stat_tracker[:game_teams][:hoa])
    expect(@stat_tracker.game_teams.result).to eq (@stat_tracker[:game_teams][:result])
    expect(@stat_tracker.game_teams.settled_in).to eq (@stat_tracker[:game_teams][:settled_in])
    expect(@stat_tracker.game_teams.head_coach).to eq (@stat_tracker[:game_teams][:head_coach])
    expect(@stat_tracker.game_teams.goals).to eq (@stat_tracker[:game_teams][:goals])
    expect(@stat_tracker.game_teams.shots).to eq (@stat_tracker[:game_teams][:shots])
    expect(@stat_tracker.game_teams.tackles).to eq (@stat_tracker[:game_teams][:tackles])
    expect(@stat_tracker.game_teams.pim).to eq (@stat_tracker[:game_teams][:pim])
    expect(@stat_tracker.game_teams.powerplayopportunities).to eq (@stat_tracker[:game_teams][:powerplayopportunities])
    expect(@stat_tracker.game_teams.powerplaygoals).to eq (@stat_tracker[:game_teams][:powerplaygoals])
    expect(@stat_tracker.game_teams.faceoffwinpercentage).to eq (@stat_tracker[:game_teams][:faceoffwinpercentage])
    expect(@stat_tracker.game_teams.giveaways).to eq (@stat_tracker[:game_teams][:giveaways])
    expect(@stat_tracker.game_teams.takeaways).to eq (@stat_tracker[:game_teams][:takeaways])
  end
end
