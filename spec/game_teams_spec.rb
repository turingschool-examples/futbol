require_relative 'spec_helper'

RSpec.describe GameTeams do
  before(:all) do
    game_teams_path = './spec/fixtures/game_teams_fixture.csv'
    game_path = './spec/fixtures/games_fixture.csv'
    team_path = './spec/fixtures/teams_fixture.csv'

    locations = {
      game_teams: game_teams_path,
      games: game_path,
      teams: team_path
    }

    @game_teams_path = CSV.read(locations[:game_teams], headers: true, skip_blanks: true, header_converters: :symbol)
    @game_path = CSV.read(locations[:games], headers: true, skip_blanks: true, header_converters: :symbol)
    @team_path = CSV.read(locations[:teams], headers: true, skip_blanks: true, header_converters: :symbol)
    @gameteams = GameTeams.new(@game_teams_path, @game_path, @team_path)
  end
  
  describe '#initialize' do
    it 'exists' do 
      expect(@gameteams).to be_an_instance_of(GameTeams)
    end
  end
  
  describe '#average_goals_by_team_hash' do 
    it 'is a helper method to group the teams to their average goals' do 
      expect(@gameteams.average_goals_by_team_hash.class).to eq(Hash)
      expect(@gameteams.average_goals_by_team_hash.count).to eq(7)
      # require 'pry'; binding.pry
    end
  end

  describe '#visitor_scores_hash' do 
    it 'returns a hash with the team id as the key and the value as the average score' do 
      expect(@gameteams.visitor_scores_hash.class).to eq(Hash)
      expect(@gameteams.visitor_scores_hash.count).to eq(7)
      # require 'pry'; binding.pry
    end
  end

  describe '#home_scores_hash' do 
    it 'returns a hash with the team id as the key and the value as the average score' do 
      expect(@gameteams.home_scores_hash.class).to eq(Hash)
      expect(@gameteams.home_scores_hash.count).to eq(7)
    end
  end

  describe '#highest_scoring_visitor' do 
    it 'returns a string of the highest scoring away team name' do 
      expect(@gameteams.highest_scoring_visitor).to eq('FC Dallas')
    end
  end

  describe '#lowest_scoring_visitor' do 
    it 'returns a string of the lowest scoring away team name' do 
      expect(@gameteams.lowest_scoring_visitor).to eq('Sporting Kansas City')
    end
  end

  describe '#highest_scoring_home_team' do
    it 'returns a string of the highest scoring home team' do 
      expect(@gameteams.highest_scoring_home_team).to eq('New York City FC')
    end
  end

  describe '#lowest_scoring_home_team' do
    it 'returns a string of the lowest scoring home team' do 
      expect(@gameteams.lowest_scoring_home_team).to eq('Sporting Kansas City')
    end
  end

  describe '#games_by_game_id' do 
    it 'is a helper method that groups the games by the game_id' do 
      expect(@gameteams.games_by_game_id.class).to eq(Hash)
    end
  end

  describe '#most_tackles' do 
    it 'is the team with the most tackles in the season' do 
      expect(@gameteams.most_tackles('20122013')).to eq('FC Dallas')
    end
  end

  describe '#fewest_tackles' do 
    it 'is the team with the fewest tackles' do 
      expect(@gameteams.fewest_tackles('20122013')).to eq('New England Revolution')
    end
  end 

  describe '#teams_with_tackles' do 
    it 'is a helper method to set team ids to their array of tackles' do 
      expect(@gameteams.teams_with_tackles([]).class).to eq(Hash)
    end
  end

  describe '#all_scores_by_team' do 
    it 'is a helper method to pair all the scores a team has' do 
      expect(@gameteams.all_scores_by_team.class).to eq(Hash)
    end
  end

  describe '#get_ratios_by_season_id' do 
    it 'gets the ratios by the season' do 
      expect(@gameteams.get_ratios_by_season_id('20122013').class).to eq(Hash)
    end
  end

  describe '#most_accurate_teams' do 
    it 'is the team that is the most accurate' do 
      expect(@gameteams.most_accurate_team('20122013')).to eq('FC Dallas')
    end
  end

  describe '#least_accurate_teams' do
    it 'is the team that is the least accurate' do
      expect(@gameteams.most_accurate_team('20122013')).to eq('FC Dallas')
    end
  end

  describe '#team_shots_by_season' do
    it 'gives the total team shots by season' do
      expect(@gameteams.team_shots_by_season('20122013').class).to eq(Hash)
    end
  end

  describe '#team_goals_by_season' do
    it 'gives the total team goals by season' do
      expect(@gameteams.team_goals_by_season('20122013').class).to eq(Hash)
    end
  end

  describe '#teams_by_id' do

  end
  
  describe '#pair_teams_with_results' do 
    it 'pairs the teams with their win and game id' do 
      expect(@gameteams.pair_teams_with_results('6').class).to eq(Hash)
    end
  end

  describe '#pair_season_with_results_by_team' do 
    it 'is a sandbox' do 
      expect(@gameteams.pair_season_with_results_by_team('6').class).to eq(Hash)
    end
  end

  describe '#best_season' do 
    it 'is the best season for a team' do 
      expect(@gameteams.best_season('6')).to eq('20122013')
    end
  end

  describe '#worst_season' do
    it 'is the best season for a team' do
      expect(@gameteams.worst_season('6')).to eq('20122013')
    end
  end

  describe '#average_win_percentage' do 
    it 'returns average win  percentage of all games for a team' do
      expect(@gameteams.average_win_percentage('6')).to eq(1.0)
    end
  end
end