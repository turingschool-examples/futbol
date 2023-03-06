require 'spec_helper'

RSpec.describe SeasonStats do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @season_stats = SeasonStats.new(locations)
  end

  # add test for winningest and worst coaches and any helper methods here

  describe '#most_accurate_team and #least_accurate_team' do
    it 'returns the name of the team witha seasons  most accurate goals to shots ratio' do
      expect(@season_stats.most_accurate_team('20132014')).to eq('Real Salt Lake')
    end

    it 'returns the name of the team with a seasons least accurate goals to shots ratio' do
      expect(@season_stats.least_accurate_team('20142015')).to eq('Columbus Crew SC')
    end
  end

  describe '#most_tackles and #fewest_tackles' do
    it 'returns the name of the team with the most tackles of a given season' do
      expect(@season_stats.most_tackles('20132014')).to eq('FC Cincinnati')
    end

    it 'returns the name of the team with the fewest tackles of a given season' do
      expect(@season_stats.fewest_tackles('20142015')).to eq('Orlando City SC')
    end
  end

  describe '#goals_to_shots_ratio' do
    it 'returns a hash of team key and goals to shots ratio' do
      expect(@season_stats.goals_to_shots_ratio('20122013')).to be_a(Hash)
      expect(@season_stats.goals_to_shots_ratio('20122013').keys.all?(Integer)).to be true
      expect(@season_stats.goals_to_shots_ratio('20122013').values.all?(Float)).to be true
    end
  end

  describe '#team_name_by_id' do
    it 'returns the team name by given id' do
      expect(@season_stats.team_name_by_id(1)).to eq('Atlanta United')
    end
  end

  describe '#games_by_season' do
    it 'games by season' do
      expect(@season_stats.games_by_season).to be_a(Hash)
    end
  end

  describe '#game_teams_by_season' do
    it 'returns an array of game_teams corresponding to a seasons games' do
      expect(@season_stats.game_teams_by_season('20122013')).to be_an(Array)
      expect(@season_stats.game_teams_by_season('20122013').count).to eq(806 * 2)
    end
  end
end
