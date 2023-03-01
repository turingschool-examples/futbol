require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:each) do
    games = './data/games.csv'
    teams = './data/teams.csv'
    game_teams = './data/game_teams.csv'
    @locations = {
      games: games,
      teams: teams,
      game_teams: game_teams
    }
    @stat_tracker = StatTracker.new(games, teams, game_teams)
  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@stat_tracker).to be_a StatTracker
      expect(@stat_tracker.games).to eq('./data/games.csv')
      expect(@stat_tracker.teams).to eq('./data/teams.csv')
      expect(@stat_tracker.game_teams).to eq('./data/game_teams.csv')
    end
  end

  describe '#self.from_csv' do
    it 'returns an instance of StatTracker' do
      expect(StatTracker.from_csv(@locations)).to be_a StatTracker
      expect(@stat_tracker.games).to eq('./data/games.csv')
      expect(@stat_tracker.teams).to eq('./data/teams.csv')
      expect(@stat_tracker.game_teams).to eq('./data/game_teams.csv')
    end
  end

  describe '#games' do
    xit 'returns an array of game instances' do
      expect(@stat_tracker.games).to be_a array
      expect(@stat_tracker.games.sample).to be_a Game
    end
    xit 'adds each instance to games class array' do
      # need to clear array?
      expect(@@games.empty?).to be false
    end
  end

  describe '#teams' do
    xit 'returns an array of team instances' do
      expect(@stat_tracker.teams).to be_a array
      expect(@stat_tracker.teams.sample).to be_a Team
    end
    xit 'adds each instance to games class array' do
      # need to clear array?
      expect(@@games.empty?).to be false
    end
  end

  describe '#game_teams' do
    xit 'returns an array of game_team instances' do
      expect(@stat_tracker.game_team).to be_a array
      expect(@stat_tracker.game_team.sample).to be_a GameTeam 
      # what are we calling this? season?
    end
    xit 'adds each instance to games class array' do
      # need to clear array?
      expect(@@games.empty?).to be false
    end
  end
end