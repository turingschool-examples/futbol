require './required_files'
include LeagueModule
include SeasonModule

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


    it 'creates a home goal hash' do
      expected = {6=>3.0,
                 3=>1.5,
                 13=>2.0,
                 7=>2.0,
                 15=>1.34,
                 4=>1.5,
                 30=>2.0,
                 19=>2.0,
                 9=>1.0}
      expect(@stat_tracker.home_goals_hash).to eq(expected)
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

    it 'returns highest average scoring of home team' do
      expect(@stat_tracker.highest_scoring_home_team).to eq("FC Dallas")
    end

    it 'returns lowest average scoring home team' do
      expect(@stat_tracker.lowest_scoring_home_team).to eq("New York City FC")
    end

		it "can return the average score per game across all seasons when they are away" do
			expect(LeagueModule.average_visitor_scores(@stat_tracker.games)).to be_a(Hash)
			expect(LeagueModule.average_visitor_scores(@stat_tracker.games)['3']).to eq(1.75)
			expect(LeagueModule.average_visitor_scores(@stat_tracker.games)['8']).to eq(2)
		end

		it "can return average away goals per team" do
			expect(LeagueModule.average_away_goals_per_team('3', @stat_tracker.games)).to eq(1.75)
		end

    it "returns the name of the team with the highest average score per game across all seasons when they are away" do
      expect(@stat_tracker.highest_scoring_visitor).to eq("Real Salt Lake")
    end

    it "returns the name of the team with the lowest average score per game across all seasons when they are away" do
      expect(@stat_tracker.lowest_scoring_visitor).to eq('Chicago Fire')
    end
  end


  describe "Season Statistics" do
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


    it 'calculates team with most tackles in season' do
      expect(@stat_tracker.most_tackles("20122013")).to eq("FC Dallas")
    end

    it 'calculates team with least tackles in season' do
      expect(@stat_tracker.least_tackles("20122013")).to eq("LA Galaxy")
    end

     it 'can determine winningest coach for a season' do
      expect(@stat_tracker.winningest_coach("20122013")).to eq "Claude Julien"
    end

    it 'can create a list of all game team objects for a given season' do
      expect(SeasonModule.game_teams_for_season("20122013", @stat_tracker.game_teams)[0]).to eq(@stat_tracker.game_teams[0])
      expect(SeasonModule.game_teams_for_season("20122013", @stat_tracker.game_teams).last).to eq(@stat_tracker.game_teams[9])
    end

    it 'can create hash with win loss record for each coach in a season' do
      game_teams_by_season = SeasonModule.game_teams_for_season("20122013", @stat_tracker.game_teams)
      expect(SeasonModule.coach_wins_losses_for_season(game_teams_by_season)["John Tortorella"]).to eq(["LOSS", "LOSS"])
    end

    it 'can calculate win percentage for each coach' do
      game_teams_by_season = SeasonModule.game_teams_for_season("20122013", @stat_tracker.game_teams)
      coach_wins_losses = SeasonModule.coach_wins_losses_for_season(game_teams_by_season)
      coach_win_percentages = SeasonModule.coach_win_percentage(coach_wins_losses)
      expect(coach_win_percentages["John Tortorella"]).to eq(0)
      expect(coach_win_percentages["Mike Babcock"]).to eq(50.0)
    end

    it 'can determine worst coach for a season' do
        expect(@stat_tracker.worst_coach("20122013")).to eq "John Tortorella"
    end

    it 'can determine team with best ratio of shots to goals for the season' do
      expect(@stat_tracker.most_accurate_team("20122013")).to eq "FC Dallas"
    end

    it 'can create hash with team_id keys and array values holding shots and goals' do
      game_teams_by_season = SeasonModule.game_teams_for_season("20122013", @stat_tracker.game_teams)
      expect(SeasonModule.team_shots_goals(game_teams_by_season)).to eq({3=>[17, 4], 6=>[28, 8], 17=>[12, 3], 16=>[25, 4]})
    end

    it 'can calculate the ratio of shots to gaols' do
      game_teams_by_season = SeasonModule.game_teams_for_season("20122013", @stat_tracker.game_teams)
      team_shots_goals = SeasonModule.team_shots_goals(game_teams_by_season)
      team_shots_goals_ratio = SeasonModule.shots_goals_ratio(team_shots_goals)
      expect(team_shots_goals_ratio).to eq({3=>4.25, 6=>3.5, 17=>4.0, 16=>6.25})
    end

    it 'can determine team with worst ratio of shots to goals for the season' do
      expect(@stat_tracker.least_accurate_team("20122013")).to eq "New England Revolution"
    end

    it 'can count the total number of teams' do
      expect(@stat_tracker.count_of_teams).to eq 32
    end

  end


  describe "Team Statistics" do
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


    it 'has team info' do
      expected = {
        :team_id=>3,
        :franchise_id=> 10,
        :team_name=> "Houston Dynamo",
        :abbreviation=> "HOU",
        :link=>"/api/v1/teams/3"
      }
      expect(@stat_tracker.team_info(3)).to eq(expected)
    end

    it 'calculates season with highest win percentage' do
      expect(@stat_tracker.best_season(16)).to eq("20152016")
    end

    it 'calculates season with lowest win percentage' do
      expect(@stat_tracker.worst_season(16)).to eq("20122013")
    end

    it 'returns team name by team id' do
      expect(@stat_tracker.team_name_by_id(17)).to eq("LA Galaxy")
    end

    it 'returns number of tackles by team id' do
      expect(@stat_tracker.tackles_by_id(19)).to eq({19 => [41, 41, 40]})
    end

    it 'returns season by game id' do
      expect(@stat_tracker.game_id_to_season("2015030133")).to eq("20152016")
    end

    it 'calculates average win percentage of all games for a team' do
      expect(@stat_tracker.average_win_percentage(16)).to eq(40.0)
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

    it 'can determine name of favorite opponent for a given team' do
      expect(@stat_tracker.favorite_opponent("New England Revolution")).to eq "LA Galaxy"
      expect(@stat_tracker.favorite_opponent("FC Dallas")).to eq "Houston Dynamo"
    end

    it "can name opponent with the highest win percentage aganist a given team" do
      expect(@stat_tracker.rival("New England Revolution")).to eq "LA Galaxy"

    end

    it 'can determine name of rival for a given team' do
      expect(@stat_tracker.rival("LA Galaxy")).to eq "New England Revolution"
      expect(@stat_tracker.rival("Houston Dynamo")).to eq "FC Dallas"

    end
  end
end
