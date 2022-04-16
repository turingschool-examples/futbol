require 'simplecov'
SimpleCov.start
require './lib/stat_tracker'
require './lib/team'
require './lib/game_team'
require './lib/game'
require 'pry'

describe StatTracker do
  before :each do
    @game_path = './data/dummy_games.csv'
    @team_path = './data/dummy_teams.csv'
    @game_teams_path = './data/dummy_game_teams.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  it 'exists' do
    expect(@stat_tracker).to be_an_instance_of(StatTracker)
  end

  it 'has game' do
    expect(@stat_tracker.games[0]).to be_a(Game)
  end

	it "has a team" do
		expect(@stat_tracker.teams[0]).to be_a(Team)
	end

  it 'has game_teams' do
    expect(@stat_tracker.game_teams[0]).to be_a(GameTeam)
  end

	describe "Game Statistics" do
		before :each do
		 @game_path = './data/dummy_games.csv'
		 @team_path = './data/dummy_teams.csv'
		 @game_teams_path = './data/dummy_game_teams.csv'

		 @locations = {
		   games: @game_path,
		   teams: @team_path,
		   game_teams: @game_teams_path
		 }
		end

		it "can calculate the total number of games played" do
		 expect(@stat_tracker.game_count).to eq 16
		end

	  it "it can calculate the highest total score of games" do
			expect(@stat_tracker.highest_total_score).to eq 5
		end

		it "can calculate the lowest total score of games" do
			expect(@stat_tracker.lowest_total_score).to eq 2
		end

		it "can return the percentage of games that a visitor has won" do
			expect(@stat_tracker.percentage_visitor_wins).to eq 43.75
		end

		it "can calculate a percentage of home wins" do
			expect(@stat_tracker.percentage_home_wins).to eq 50.0
	  end

    it "can calculate the percentage of games that has resulted in a tie" do
			expect(@stat_tracker.percentage_ties).to eq 6.25
		end

	  it "can calculate average goals per game" do
	    expect(@stat_tracker.average_goals_per_game).to eq 3.69
	  end

    it 'can count the total number of teams' do
	    expect(@stat_tracker.count_of_teams).to eq 32
	  end

		it "can count the number of games by season" do
			expect(@stat_tracker.count_of_games_by_season).to eq({"20122013"=>7, "20152016"=>5, "20132014"=>4})
		end

	  it "can calculate average goals per season" do

	    expected = {
	      "20122013" => 4.43,
	      "20152016" => 3.00,
	      "20132014" => 3.25
	    }
	    expect(@stat_tracker.average_goals_per_season).to eq expected
		end
	end

  describe "League Statistics" do
    before :each do
      @game_path = './data/dummy_games.csv'
      @team_path = './data/dummy_teams.csv'
      @game_teams_path = './data/dummy_game_teams.csv'

      @locations = {
        games: @game_path,
        teams: @team_path,
        game_teams: @game_teams_path
      }
    end

    it 'can count the total number of teams' do
      expect(@stat_tracker.count_of_teams).to eq 32
    end


    it "can calculate highest average number of goals scored across all seasons" do
      expect(@stat_tracker.best_offense).to eq "Sporting Kansas City"

    end

    it "can calculate lowest average of goals scored per game across all seasons " do
      expect(@stat_tracker.worst_offense).to eq "New England Revolution"
    end

    it "can return the most goals scored by a team in a single game" do
      expect(@stat_tracker.most_goals_scored(26)).to eq 3

    end
    it "can return the fewest amount of goals scored by a team in a single game" do
      expect(@stat_tracker.fewest_goals_scored(16)).to eq 0
    end
  end

  describe "Season Statistics" do

    it 'can determine winningest coach for a season' do
      expect(@stat_tracker.winningest_coach("20122013")).to eq "Claude Julien"
    end

    it 'can determine worst coach for a season' do
        expect(@stat_tracker.worst_coach("20122013")).to eq "John Tortorella"
    end

    it 'can determine team with best ratio of shots to goals for the season' do
      expect(@stat_tracker.most_accurate_team("20122013")).to eq "FC Dallas"
    end

    it 'can determine team with worst ratio of shots to goals for the season' do
      expect(@stat_tracker.least_accurate_team("20122013")).to eq "New England Revolution"
    end

    it "can name opponent with the highest win percentage aganist a given team" do
      expect(@stat_tracker.rival(16)).to eq "FC Dallas"

    end
  end

end
