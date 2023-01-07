require './spec/spec_helper'

describe LeagueStats do
  before do 
    teams_path = './data/teams.csv'
    game_teams_path = './data/game_teams_sample.csv'
    games_path = './data/games_sample.csv'
    @game_teams = GameTeams.create_game_teams(game_teams_path)
    @teams = Team.create_teams(teams_path)
    @games = Game.create_games(games_path)
  end

  let(:league_stat) { LeagueStats.new(@game_teams, @teams, @games) }

  describe '' do
    it 'exists' do
      expect(league_stat).to be_a(LeagueStats)
    end
  end

  describe '#count_of_teams' do
    it 'returns the total number of teams' do
      expect(league_stat.count_of_teams).to eq(32)
    end
  end

  describe '#highest_scoring_visitor' do
    it 'returns the NAME of the team who scored the most goals per game as the away team' do
      expect(league_stat.highest_scoring_visitor).to eq("FC Dallas")
    end
  end

  describe '#lowest_scoring_visitor' do
    it 'returns the NAME of the team who scored the most goals per game as the away team' do
      expect(league_stat.lowest_scoring_visitor).to eq("FC Cincinnati")
    end
  end

  describe '#highest_scoring_home_team' do
  it 'returns the NAME of the team who scored the most goals per game as the home team' do
    expect(league_stat.highest_scoring_home_team).to eq("Toronto FC")
  end
end

  describe '#lowest_scoring_home_team' do
    it 'returns the NAME of the team who scored the most goals per game as the home team' do
      expect(league_stat.lowest_scoring_home_team).to eq("Atlanta United")
    end
  end

  describe '#best_offense' do
    it 'returns the team NAME with the MOST AVERAGE GOALS per game across ALL SEASONS' do
      expect(league_stat.best_offense).to eq("Toronto FC")
    end
  end

  describe '#worst_offense' do
    it 'returns the team NAME with the LEAST AVERAGE GOALS per game across ALL SEASONS' do
      expect(league_stat.worst_offense).to eq("DC United")
    end
  end
end
