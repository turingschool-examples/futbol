require "./lib/stat_tracker.rb"
require 'csv'
require "./lib/game.rb"

describe Game do
  before :each do
    # @game =  Game.new({ game_id: "2012030221",
    #   season: "20122013",
    #   type: "Postseason",
    #   date_time: "5/16/13",
    #   away_team_id: "3",
    #   home_team_id: "6",
    #   away_goals: "2",
    #   home_goals: "3",
    #   venue: "Toyota Stadium",
    #   venue_link: "/api/v1/venues/null" }
    # )
    @locations = './data/games.csv'
    @game = Game.create_multiple_games(@locations)
    
  end

  it 'exists' do
    expect(@game).to be_an(Array)
  end

  it 'can read a season' do
    expect(@game[0].season).to eq("20122013")
  end

  it 'reads the correct type' do
    
    expect(@game[0].type).to eq("Postseason")
  end

  it 'reads the correct game_id' do
   
  end







  
  
  
  
  
  
  
  
  
end
