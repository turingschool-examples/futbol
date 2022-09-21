require 'spec_helper'
require 'team'
require 'league'
RSpec.describe Team do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    @games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @team = Team.new(@teams_data, @game_teams_data, @games_data)
  end
  describe 'team statistics' do
    it 'can make a hash with key/value pairs for the following attributes' do
      expected = {
        'team_id' => '18',
        'franchise_id' => '34',
        'team_name' => 'Minnesota United FC',
        'abbreviation' => 'MIN',
        'link' => '/api/v1/teams/18'
      }
      expect(@team.team_info('18')).to eq(expected)
    end
  end

  describe '#average_win_percentage' do
    it 'can tell the average win rate of a given team' do
      expect(@team.average_win_percentage('6')).to eq 0.49
    end
  end

  describe '#most_goals_scored' do
    it 'can show what game a team scored the most goals' do
      expect(@team.most_goals_scored('18')).to eq 7
    end
  end

  describe '#fewest_goals_scored' do
    it '#fewest_goals_scored' do
      expect(@team.fewest_goals_scored('18')).to eq 0
    end
  end

  # describe '#favorite_opponent' do
  #   it '#favorite_opponent' do
  #     expect(@team.favorite_opponent('18')).to eq 'DC United'
  #   end
  # end

  # describe '#rival' do
  #   it '#rival' do
  #     expect(@team.rival('18')).to eq('Houston Dash').or(eq('LA Galaxy'))
  #   end
  # end
  describe '#win_loss_hashes' do
    it 'can make hashes' do
      expect(@team.win_loss_hashes("18").length).to eq(31)
    end
  end
end
