require '../futbol/lib/stat_tracker'
require 'csv'
require 'pry'

RSpec.describe StatTracker do
  before(:each) do
    # Convert local variables to instance variables
    @games_path = './data/games.csv'
    @teams_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @games_path,
      teams: @teams_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  it 'exists' do
    expect(@stat_tracker).to be_an_instance_of(StatTracker)
  end

  describe 'from_csv' do
    it 'reads the correct CSV files' do
      # Now @locations and @games_path are properly set in before(:each)
      stat_tracker = StatTracker.from_csv(@locations)
      games = CSV.read(@games_path, headers: true, header_converters: :symbol)
      expect(games).not_to be_empty
      expect(games.headers).to include(:game_id, :season, :home_team_id)
    end

    it 'creates StatTracker with the correct data' do
      allow(CSV).to receive(:read).with(@locations[:games], headers: true, header_converters: :symbol).and_return([
        { game_id: "2012030221", season: "20122013", home_team_id: "6", away_team_id: "3" },
        { game_id: "2012030222", season: "20122013", home_team_id: "4", away_team_id: "1" }
      ])
      allow(CSV).to receive(:read).with(@locations[:teams], headers: true, header_converters: :symbol).and_return([
        { team_id: 1, team_name: 'Team A', abbreviation: 'TA' },
        { team_id: 2, team_name: 'Team B', abbreviation: 'TB' }
      ])
      allow(CSV).to receive(:read).with(@locations[:game_teams], headers: true, header_converters: :symbol).and_return([
        { game_id: "2012030221", team_id: 3, hoa: 'home' },
        { game_id: "2012030222", team_id: 1, hoa: 'away' }
      ])
      stat_tracker = StatTracker.from_csv(@locations)
  
      expect(stat_tracker.games).to all(be_an_instance_of(Games))
      expect(stat_tracker.teams).to all(be_an_instance_of(Teams))
      expect(stat_tracker.game_teams).to all(be_an_instance_of(GameTeams))
    end

    it 'reads the CSV data correctly and initializes the correct objects' do
      stat_tracker = StatTracker.from_csv(@locations)
      games_first_row = stat_tracker.games.first
      expect(games_first_row).to have_attributes(
        game_id: be_a(Integer),
        season: be_a(Integer),
        type: be_a(String),
        date_time: be_a(String),
        home_team_id: be_a(Integer),
        away_team_id: be_a(Integer),
        away_goals: be_a(Integer),
        home_goals: be_a(Integer),
        venue: be_a(String),
        venue_link: be_a(String)
      )
      # binding.pry
    end

    it "#highest_total_score" do
    expect(@stat_tracker.highest_total_score).to eq 11
    end

    it "#lowest_total_score" do
    expect(@stat_tracker.lowest_total_score).to eq 0
    end

    it "#percentage_home_wins" do
    expect(@stat_tracker.percentage_home_wins).to eq 0.44
    end

    it "#percentage_visitor_wins" do
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
    end

    it "#percentage_ties" do
    expect(@stat_tracker.percentage_ties).to eq 0.20
    end
  end

  
end