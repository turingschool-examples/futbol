require 'spec_helper'

RSpec.describe StatsManager do 
  before(:each) do 
    @stats_manager = StatsManager.new
  end

  describe "#Initialize" do 
    it "exists w/ attribute" do 
      expect(@stats_manager).to be_a(StatsManager)
      expect(@stats_manager.stats).to eq({games: [], teams: [], game_teams: []})
    end
  end

  describe "#Create_games" do 
    before(:each) do 
      @game_data = {
        away_goals: "2",
        away_team_id: "3",
        date_time: "5/16/13",
        game_id: "2012030221",
        home_goals: "3",
        home_team_id: "6",
        season: "20122013",
        type: "Postseason",
        venue: "Toyota Stadium",
        venue_link: "/api/v1/venues/null"
      }
    end

    it "can create a game" do 
      @stats_manager.create_games(:games, @game_data)

      test_game = @stats_manager.stats[:games].first

      expect(test_game).to be_a(Game)
    end
  end
  
  describe "#Create_teams" do
    it "can create a team" do 
      team_data = {
        abbreviation: "ATL",
        franchise_id: "23",
        link: "/api/v1/teams/1",
        stadium: "Mercedes-Benz Stadium",
        team_id: "1",
        team_name: "Atlanta United"
      }

      @stats_manager.create_teams(:teams, team_data)

      test_teams = @stats_manager.stats[:teams].first

      expect(test_teams).to be_a(Team)
    end
  end

  describe "#Create_game_teams" do
    it "can create a game_team" do 
      game_team_data = {
        face_off_win_percentage: "44.8",
        game_id: "2012030221",
        giveaways: "17",
        goals: "2",
        head_coach: "John Tortorella",
        hoa: "away",
        pim: "8",
        power_play_goals: "0",
        power_play_opportunities: "3",
        result: "LOSS",
        settled_in: "OT",
        shots: "8",
        tackles: "44",
        takeaways: "7",
        team_id: "3"
      }

      @stats_manager.create_game_teams(:game_teams, game_team_data)

      test_game_teams = @stats_manager.stats[:game_teams].first

      expect(test_game_teams).to be_a(GameTeam)
    end
  end

  describe "#Stat_organizer" do 
    it "can create game objects from a csv file" do 
      file_path = "./data/games.csv"
      expect(@stats_manager.stats[:games]).to eq([]) 
      @stats_manager.stat_organizer(file_path, :games)
      expect(@stats_manager.stats[:games].first).to be_a(Game)
    end
    
    it "can create team objects from a csv file" do 
      file_path = "./data/teams.csv"
      expect(@stats_manager.stats[:teams]).to eq([]) 
      @stats_manager.stat_organizer(file_path, :teams)
      expect(@stats_manager.stats[:teams].first).to be_a(Team)
    end
    
    it "can create game_team objects from a csv file" do 
      file_path = "./data/game_teams.csv"
      expect(@stats_manager.stats[:game_teams]).to eq([]) 
      @stats_manager.stat_organizer(file_path, :game_teams)
      expect(@stats_manager.stats[:game_teams].first).to be_a(GameTeam)
    end
  end
end