require './spec_helper'
require './lib/stat_tracker'
require 'csv'

RSpec.describe StatTracker do
  before(:each) do
    @game_path = './data/games_dummy.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams_dummy.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    # @stat_tracker = StatTracker.from_csv(@locations)
  end

  it 'exists' do
    stat_tracker = StatTracker.new(@locations)
    expect(stat_tracker).to be_instance_of StatTracker
  end

  it 'loads from csv' do
    stat_tracker = StatTracker.from_csv(@locations)
    # require "pry"; binding.pry
    expect(stat_tracker).to be_instance_of StatTracker
    expect(stat_tracker.games.class).to be CSV::Table
    expect(stat_tracker.teams.class).to be CSV::Table
    expect(stat_tracker.game_teams.class).to be CSV::Table
  end


end
