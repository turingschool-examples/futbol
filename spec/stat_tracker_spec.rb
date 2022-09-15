require 'rspec'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:each) do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams_dummy.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe '#initialize' do
  end

  describe '#highest_total_score' do
    it 'returns highest total score of all games' do
      expect(@stat_tracker.highest_total_score).to eq(5)
    end
  end

  describe '#lowest_total_score' do
    it 'returns lowest total score of all games' do
      expect(@stat_tracker.lowest_total_score).to eq(1)
    end
  end


  describe '#percentage_ties' do
    it 'returns the percent that the games have ended in a tie' do
      expect(@stat_tracker.percentage_ties).to eq(5.88)
    end
  end

  describe '#average_goals_per_game' do
    xit 'returns the average number of goals scored in a game across all seasons' do
      expect(@stat_tracker.average_goals_per_game).to eq(3.78)
    end
  end

  describe '#percentage_home_wins' do
    it 'returns the percentage of the home team wins' do
      expect(@stat_tracker.percentage_home_wins).to eq(55.56)
    end
  end

  describe '#percentage_visitor_wins' do
    it 'returns the percentage of the visitor team wins' do
      expect(@stat_tracker.percentage_visitor_wins).to eq(44.44)
    end
  end

  describe '#count_of_teams' do
    it 'counts all unique teams' do
      expect(@stat_tracker.count_of_teams).to eq(9)
    end
  end

  describe '#return_column' do
    it 'is an integer' do
      # allow(fake_data).to receive(:)
      # return_column(fake_data, header)
    end
  end

  describe 'count_of_games_by_season' do
    it 'counts games by season' do
      expect(@stat_tracker.count_of_games_by_season).to eq({"20122013"=>9, "20132014" => 1})
    end
  end

  describe '#average_goals_by_season' do
    it 'tabulates average goals by season' do
      # require 'pry'; binding.pry
      expect(@stat_tracker.average_goals_by_season).to eq({"20122013"=>3.78, '20132014' => 3.9})
    end
  end

  describe '#best_offense'  do
    it 'can return Name of the team with the highest avg # of goals/game scored across all seasons' do
      # require 'pry'; binding.pry
      expect(@stat_tracker.best_offense).to be_a String
    end
  end

  describe '#worst_offense' do
    it 'can return Name of the team with the lowest avg # of goals/game scored across all seasons' do
      # require 'pry'; binding.pry
      expect(@stat_tracker.worst_offense).to be_a String
    end
  end

  describe '#winningest_coach' do
    it 'can return Name of the Coach with the best win percentage for the season' do
      # array_of_hashes = @stat_tracker.game_teams.map { |x| x.to_h }
      # coaches_hash = Hash.new { |h,k| h[k] = 0 }
      # array_of_hashes.each do |hash|
      #   coaches_hash[hash[:head_coach]] += 1
      # end

      # win_percentages = coaches_hash.each do |k,v|
      #   coaches_hash[k] = ((array_of_hashes.find_all { |hash| hash[:head_coach] == k && hash[:result] == "WIN" }.count) / v).to_f.round(2)
      # end
      # this just grabs the coach name and want to use this for the key
      # this ends up gathering all the results of games they coached
      # this iterates over the data and grabs all the results and pushes to the array
      
      @stat_tracker.game_teams.each do |csv_row|
        coach = csv_row[:head_coach]
        all_results = []
        if csv_row[:head_coach] == coach
          all_results << csv_row[:result]
        end
      end
      # this grabs the total number of games
      j_torts_total_games = j_torts.count
      # this counts the total number of wins
      j_torts_wins = j_torts.count { |x| x == "WIN" }
      # this returns the win_percentage as a float
      win_percentage = (j_torts_wins / j_torts_total_games.to_f).round(2)
      # returns the hash
      coach_and_win_percentage = {
        @stat_tracker.game_teams[19][:head_coach] => (win_percentage) * 100
      }
      require 'pry'; binding.pry
      expect(@stat_tracker.winningest_coach).to eq('someone')
    end

    describe '#percentage_home_wins' do
      it 'finds the percetage of home wins' do

      end
    end
  end

  describe '#average_win_percentage' do 
    it 'calculates average win percentage of a single team' do 
      expect(@stat_tracker.average_win_percentage(3)).to eq (0)
      expect(@stat_tracker.average_win_percentage(16)).to eq (42.86)
    end
  end

  describe '#most_accurate_team' do 
    it 'returns name of team with the best shots to goals ratio' do 
      expect(@stat_tracker.most_accurate_team).to eq('FC Dallas')
    end
  end

  describe '#least_accurate_team' do 
    it 'returns name of team with the worst shots to goals ratio' do 
      expect(@stat_tracker.least_accurate_team).to eq('Sporting Kansas City')
    end
  end
end
