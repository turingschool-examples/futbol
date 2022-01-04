require './lib/stat_tracker'
require 'pry'
require_relative 'spec_helper'

RSpec.describe StatTracker do
  # before(:each) do
  #   game_path = './data/games.csv'
  #   team_path = './data/teams.csv'
  #   game_teams_path = './data/game_teams.csv'
  #
  #   locations = {
  #     games: game_path,
  #     teams: team_path,
  #     game_teams: game_teams_path
  #     }
  # end

  it 'exists' do
    stat_tracker = StatTracker.new("places")
    # binding.pry
    expect(stat_tracker).to be_a(StatTracker)
  end

  it 'from CSV create new StatTracker' do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)
    expect(stat_tracker).to be_a(StatTracker)
    expect(stat_tracker.locations).to eq(locations)
  end

end
