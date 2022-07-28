require './lib/stat_tracker.rb'
require_relative 'spec_helper.rb'


describe StatTracker do

  before :each do

    @game_path = './data/games_dummy.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams_dummy.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)

  end

  describe '.from_csv(locations)' do
    it 'returns an instance of StatTracker' do
      expect(StatTracker.from_csv(@locations)).to be_an_instance_of(StatTracker)
    end


    it "read csv files" do
      expect(@stat_tracker.games).to eq(CSV.table(@game_path))
      expect(@stat_tracker.teams).to eq(CSV.table(@team_path))
      expect(@stat_tracker.game_teams).to eq(CSV.table(@game_teams_path))
    end

  end

  describe 'Game Statistics' do



    it 'percentage_visitor_wins' do
   #move to correct location
        expect(@stat_tracker.percentage_visitor_wins).to eq(13.33)
    end

    it "finds highest total score" do
      expect(@stat_tracker.highest_total_score).to eq(7)
    end

    it 'can return the lowest score' do
      expect(@stat_tracker.lowest_total_score).to eq(1)
    end

    it "tracks wins" do
      expect(@stat_tracker.game_wins).to eq(29)
    end

    it "tracks losses" do
      expect(@stat_tracker.game_losses).to eq(29)
    end

    it "tracks home games" do
      expect(@stat_tracker.home_games).to eq(30)
    end

    it "tracks away games" do
      expect(@stat_tracker.away_games).to eq(30)
    end

    it "calculates home wins" do
      expect(@stat_tracker.home_wins).to eq(21)
    end

    it 'calculates percentage wins' do
      expect(@stat_tracker.percentage_home_wins).to eq(70.0)
    end

    it "returns the percentage of tied games" do
      expect(@stat_tracker.percentage_ties).to eq(17.8)
    end

    it 'average goals' do
      expect(@stat_tracker.average_goals_per_game).to eq(4)
    end

    it 'Has hash with season names as keys and counts of games as values' do
      expect(@stat_tracker.count_of_games_by_season).to eq({
          20122013 => 28,
          20132014 => 33,
          20142015 => 28,
          20162017 => 12,
      })
    end
  end

  describe 'League Statistics' do

    it 'can return total number of teams in the data' do
      expect(@stat_tracker.count_of_teams).to eq(32)
    end

    xit 'can return Name of the team with the highest average number of goals scored per game across all seasons' do
      expect(@stat_tracker.best_offense).to eq("")
    end

    xit 'can return Name of the team with the lowest average number of goals scored per game across all seasons' do
      expect(@stat_tracker.worst_offense).to eq("")
    end

    it 'can return Name of the team with the highest average score per game across all seasons when they are away' do
      expect(@stat_tracker.highest_scoring_visitor).to eq("Utah Royals FC")
    end

    it 'can return Name of the team with the highest average score per game across all seasons when they are home' do
      expect(@stat_tracker.highest_scoring_home_team).to eq("New York City FC")
    end

    xit 'can return Name of the team with the lowest average score per game across all seasons when they are a visitor' do
      expect(@stat_tracker.lowest_scoring_visitor).to eq("")
    end

    xit 'can return Name of the team with the lowest average score per game across all seasons when they are at home' do
      expect(@stat_tracker.lowest_scoring_home_team).to eq("")
    end
  end

  describe 'Season Statistics' do

    xit 'can show name of coach witht he best win percentage of the season' do
      expect(@stat_tracker.winningest_coach).to eq("")
    end

    xit 'can show name with the worst win percentage for the season' do
      expect(@stat_tracker.worst_coach).to eq("")
    end

    xit 'can show name of the team with the best ratio of shots to goals for the season' do
      expect(@stat_tracker.most_accurate_team).to eq("")
    end

    xit 'can show name of the team with the worst ratio of shots to goals for the season' do
      expect(@stat_tracker.least_accurate_team).to eq("")
    end

    xit 'can show name of the team with most tackles in the season' do
      expect(@stat_tracker.fewest_tackles).to eq("")
    end
  end

  describe 'Team Statistics' do

    xit 'can return a hash with key/value pairs for the following attributes: team_id, franchise_id, team_name, abbreviation, and link' do
      expect(@stat_tracker.team_info).to eq({})
    end

    xit 'can show season with the highest win percentage for a team' do
      expect(@stat_tracker.best_season).to eq("")
    end

    xit 'can show season with the lowest win percentage for a team' do
      expect(@stat_tracker.average_win_percentage).to eq#(float)
    end

    xit 'can return hgihest number of goals a particular team has scored in a  single game' do
      expect(@stat_tracker.most_goals_scored).to eq#(integer)
    end

    xit 'can return lowest number of goals a particular team has scored in a single game' do
       expect(@stat_tracker.fewest_goals_scored).to eq#(integer)
    end

    xit 'can return name of the opponent that has the lowest win percentage against the given team' do
      expect(@stat_tracker.favorite_opponent).to eq("")
    end

    xit 'can return name of the opponent that has the highest win percentage against the given team' do
      expect(@stat_tracker.rival).to eq("")
    end
  end

end
