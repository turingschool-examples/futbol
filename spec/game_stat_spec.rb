require 'spec_helper'

RSpec.configure do |config| 
  config.formatter = :documentation 
end

RSpec.describe GameStat do
  it 'exists' do
      expect(GameStat.new).to be_a GameStat
  end

  before(:each) do
    game_path = './data/dummy_games.csv'
    team_path = './data/dummy_teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    @locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  it 'can access StatTracker object' do
      game_statistics = GameStat.new

      require 'pry'; binding.pry
  end

  desctribe 'Module#GameStat' do
      describe 'can return highest total score' do
      end

      describe 'can return highest total score' do
      end

      descrive 'can return percentage of ties' do
      end

      describe 'can return percentage home wins' do
      end

      describe 'can return percentage visitor wins' do
      end

      describe 'returns count of games by seasons' do
      end

      describe 'returns average goals per game' do
      end

      describe 'returns average goals by season' do 
      end
  end
end



# RSpec.describe Game do 
#   before(:each) do 
#     game_path = './data/dummy_games.csv'
#     team_path = './data/dummy_teams.csv'
#     game_teams_path = './data/dummy_game_teams.csv'

#     locations = {
#       games: game_path,
#       teams: team_path,
#       game_teams: game_teams_path
#     }

    
#   end
# end

