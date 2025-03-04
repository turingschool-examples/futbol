require 'spec_helper'

# Configures RSpec to use the documentation formatter
RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe StatTracker do
  before(:each) do # we are just going to use the default CSV files that we have here from now (copy pasted from runner.rb)
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @StatTracker = StatTracker.from_csv(@locations)
  end

  describe 'initialization' do
    it '#initialize' do
      expect(@StatTracker).to be_an_instance_of(StatTracker)
    end

    it '#attributes' do
      expect(@StatTracker.games).not_to be_empty
      expect(@StatTracker.teams).not_to be_empty
      expect(@StatTracker.game_teams).not_to be_empty
      expect(@StatTracker.game_statistics).to be_an_instance_of(GameStatistics)
    end
  end

  # Placeholder for instance methods tests
  describe 'instance methods' do
    # Add tests for instance methods here
  end

  # class methods only (keyword 'self')
  describe 'class methods' do
    it '::from_csv' do
      expect(@StatTracker).to be_an_instance_of(StatTracker)
      expect(@StatTracker.games).not_to be_empty
      expect(@StatTracker.teams).not_to be_empty
      expect(@StatTracker.game_teams).not_to be_empty
    end
  end
end