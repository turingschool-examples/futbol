
require './spec/spec_helper'

RSpec.describe GameTeams do

  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }


    @game_teams = GameTeams.new(locations)
    @games = Games.new(locations)
    @teams = League.new(locations)
  end

  describe 'gameteams' do
    it 'exists' do
      expect(@game_teams).to be_a(GameTeams)
    end
  end

  describe 'best_offense and worst_offense' do
    it 'best_offense' do
      index = @teams.team_id.find_index(@game_teams.best_offense)
      expect(@teams.teamname[index]).to eq("Reign FC")
      expect(@game_teams.best_offense).to eq("54")
    end

    it 'worst_offense' do
      index = @teams.team_id.find_index(@game_teams.worst_offense)
      expect(@teams.teamname[index]).to eq("Utah Royals FC")
      expect(@game_teams.worst_offense).to eq("7")
    end

    describe 'highest_scoring_visitor and lowest_scoring_visitor' do
      it 'highest_scoring_visitor' do
        index = @teams.team_id.find_index(@game_teams.highest_scoring_visitor)
        expect(@teams.teamname[index]).to eq("FC Dallas")
        expect(@game_teams.highest_scoring_visitor).to eq("6")
      end

      it 'lowest_scoring_visitor' do
        index = @teams.team_id.find_index(@game_teams.lowest_scoring_visitor)
        expect(@teams.teamname[index]).to eq("San Jose Earthquakes")
        expect(@game_teams.lowest_scoring_visitor).to eq("27")
      end
    end

    describe 'highest_scoring_home_team and lowest_scoring_home_team' do
      it 'highest_scoring_home_team' do
        index = @teams.team_id.find_index(@game_teams.highest_scoring_home_team)
        expect(@teams.teamname[index]).to eq("Reign FC")
        expect(@game_teams.highest_scoring_home_team).to eq("54")
      end

      it 'lowest_scoring_home_team' do
        index = @teams.team_id.find_index(@game_teams.lowest_scoring_home_team)
        expect(@teams.teamname[index]).to eq("Utah Royals FC")
        expect(@game_teams.lowest_scoring_home_team).to eq("7")
      end
    end

    describe 'winningest_coach and worst_coach' do
      it 'winningest coach' do
        expect(@game_teams.winningest_coach('20132014')).to eq("Claude Julien")
        expect(@game_teams.winningest_coach('20142015')).to eq("Alain Vigneault")
        expect(@game_teams.winningest_coach('20152016')).to eq("Barry Trotz")
        expect(@game_teams.winningest_coach('20162017')).to eq("Bruce Cassidy")
        expect(@game_teams.winningest_coach('20172018')).to eq("Bruce Cassidy")
      end

      it 'worst_coach' do
        expect(@game_teams.worst_coach('20132014')).to eq("Peter Laviolette")
        expect(@game_teams.worst_coach('20142015')).to eq("Ted Nolan")
        expect(@game_teams.worst_coach('20152016')).to eq("Todd Richards")
        expect(@game_teams.worst_coach('20162017')).to eq("Dave Tippett")
        expect(@game_teams.worst_coach('20172018')).to eq("Phil Housley")
      end
    end
    
    describe 'least_accurate_team and most_accurate_team' do
      it 'least_accurate_team(20122013)' do
        index = @teams.team_id.find_index(@game_teams.least_accurate_team('20122013'))
        expect(@teams.teamname[index]).to eq("New York City FC")
        expect(@game_teams.least_accurate_team('20122013')).to eq("9")
        
        index = @teams.team_id.find_index(@game_teams.least_accurate_team('20132014'))
        expect(@teams.teamname[index]).to eq("New York City FC")
        expect(@game_teams.least_accurate_team('20132014')).to eq("9")

        index = @teams.team_id.find_index(@game_teams.least_accurate_team('20142015'))
        expect(@teams.teamname[index]).to eq("Columbus Crew SC")
        expect(@game_teams.least_accurate_team('20142015')).to eq("53")
        
        index = @teams.team_id.find_index(@game_teams.least_accurate_team('20152016'))
        expect(@teams.teamname[index]).to eq("North Carolina Courage")
        expect(@game_teams.least_accurate_team('20152016')).to eq("10")
        
        index = @teams.team_id.find_index(@game_teams.least_accurate_team('20162017'))
        expect(@teams.teamname[index]).to eq("FC Cincinnati")
        expect(@game_teams.least_accurate_team('20162017')).to eq("26")
        
        index = @teams.team_id.find_index(@game_teams.least_accurate_team('20172018'))
        expect(@teams.teamname[index]).to eq("Toronto FC")
        expect(@game_teams.least_accurate_team('20172018')).to eq("20")
      end

      it 'most_accurate_team' do
        index = @teams.team_id.find_index(@game_teams.most_accurate_team('20122013'))
        expect(@teams.teamname[index]).to eq("DC United")
        expect(@game_teams.most_accurate_team('20122013')).to eq("14")
        
        index = @teams.team_id.find_index(@game_teams.most_accurate_team('20132014'))
        expect(@teams.teamname[index]).to eq("Real Salt Lake")
        expect(@game_teams.most_accurate_team('20132014')).to eq("24")
        
        index = @teams.team_id.find_index(@game_teams.most_accurate_team('20142015'))
        expect(@teams.teamname[index]).to eq("Toronto FC")
        expect(@game_teams.most_accurate_team('20142015')).to eq("20")
        
        index = @teams.team_id.find_index(@game_teams.most_accurate_team('20152016'))
        expect(@teams.teamname[index]).to eq("New York City FC")
        expect(@game_teams.most_accurate_team('20152016')).to eq("9")
        
        index = @teams.team_id.find_index(@game_teams.most_accurate_team('20162017'))
        expect(@teams.teamname[index]).to eq("Portland Thorns FC")
        expect(@game_teams.most_accurate_team('20162017')).to eq("52")
        
        index = @teams.team_id.find_index(@game_teams.most_accurate_team('20172018'))
        expect(@teams.teamname[index]).to eq("Portland Timbers")
        expect(@game_teams.most_accurate_team('20172018')).to eq("15")
      end
    end

    describe 'most_tackles and least_tackles' do
      it 'most_tackles' do
        index = @teams.team_id.find_index(@game_teams.most_tackles('20122013'))
        expect(@teams.teamname[index]).to eq("FC Cincinnati")
        expect(@game_teams.most_tackles('20122013')).to eq("26")
        
        index = @teams.team_id.find_index(@game_teams.most_tackles('20132014'))
        expect(@teams.teamname[index]).to eq("FC Cincinnati")
        expect(@game_teams.most_tackles('20132014')).to eq("26")
        
        index = @teams.team_id.find_index(@game_teams.most_tackles('20142015'))
        expect(@teams.teamname[index]).to eq("Seattle Sounders FC")
        expect(@game_teams.most_tackles('20142015')).to eq("2")
        
        index = @teams.team_id.find_index(@game_teams.most_tackles('20152016'))
        expect(@teams.teamname[index]).to eq("Seattle Sounders FC")
        expect(@game_teams.most_tackles('20152016')).to eq("2")
        
        index = @teams.team_id.find_index(@game_teams.most_tackles('20162017'))
        expect(@teams.teamname[index]).to eq("Sporting Kansas City")
        expect(@game_teams.most_tackles('20162017')).to eq("5")
        
        index = @teams.team_id.find_index(@game_teams.most_tackles('20172018'))
        expect(@teams.teamname[index]).to eq("Portland Timbers")
        expect(@game_teams.most_tackles('20172018')).to eq("15")
      end

      it 'least_tackles' do
        index = @teams.team_id.find_index(@game_teams.least_tackles('20122013'))
        expect(@teams.teamname[index]).to eq("Atlanta United")
        expect(@game_teams.least_tackles('20122013')).to eq("1")
        
        index = @teams.team_id.find_index(@game_teams.least_tackles('20132014'))
        expect(@teams.teamname[index]).to eq("Atlanta United")
        expect(@game_teams.least_tackles('20132014')).to eq("1")
        
        index = @teams.team_id.find_index(@game_teams.least_tackles('20142015'))
        expect(@teams.teamname[index]).to eq("Orlando City SC")
        expect(@game_teams.least_tackles('20142015')).to eq("30")
        
        index = @teams.team_id.find_index(@game_teams.least_tackles('20152016'))
        expect(@teams.teamname[index]).to eq("Montreal Impact")
        expect(@game_teams.least_tackles('20152016')).to eq("23")
        
        index = @teams.team_id.find_index(@game_teams.least_tackles('20162017'))
        expect(@teams.teamname[index]).to eq("New England Revolution")
        expect(@game_teams.least_tackles('20162017')).to eq("16")
        
        index = @teams.team_id.find_index(@game_teams.least_tackles('20172018'))
        expect(@teams.teamname[index]).to eq("New England Revolution")
        expect(@game_teams.least_tackles('20172018')).to eq("16")

      end
    end
  end
end