require 'game.rb'

RSpec.describe Game do
  let(:game_1) {
    Game.new({
      game_id: "2017030163",
      season: "20172018",
      type: "Postseason",
      date_time: "4/15/18",
      away_team_id: "52",
      home_team_id: "30",
      away_goals: "2",
      home_goals: "4",
      venue: "Exploria Stadium",
      venue_link: "/api/v1/venues/null"}
    )
  }

  let(:game_2) {
    Game.new({
      game_id: "2017030165",
      season: "20172018",
      type: "Postseason",
      date_time: "4/20/18",
      away_team_id: "30",
      home_team_id: "52",
      away_goals: "0",
      home_goals: "3",
      venue: "Providence Park",
      venue_link: "/api/v1/venues/null"}
    )
  }

  let(:game_3) {
    Game.new({
      game_id: "2017030165",
      season: "20172018",
      type: "Postseason",
      date_time: "4/20/18",
      away_team_id: "30",
      home_team_id: "52",
      away_goals: "1",
      home_goals: "0",
      venue: "Providence Park",
      venue_link: "/api/v1/venues/null"}
    )
  }

  it 'exists' do 
    expect(game_1.game_id).to eq(2017030163)
    expect(game_1.season).to eq("20172018")
    expect(game_1.type).to eq("Postseason")
    expect(game_1.date_time).to eq("4/15/18")
    expect(game_1.away_team_id).to eq(52)
    expect(game_1.home_team_id).to eq(30)
    expect(game_1.away_goals).to eq(2)
    expect(game_1.home_goals).to eq(4)
    expect(game_1.venue).to eq("Exploria Stadium",)
    expect(game_1.venue_link).to eq("/api/v1/venues/null")
  end

  it 'can calculate the highest total score of a game' do
    expect(described_class.highest_total_score([game_1, game_2])).to eq(6)
  end

  it 'can calculate the lowest total score of a game' do
    expect(described_class.lowest_total_score([game_1, game_2])).to eq(3)  
  end

  it 'can calculate the percentage of home wins' do
    expect(described_class.percentage_home_wins([game_1, game_2, game_3])).to eq(66.67)  
  end

  it 'can calculate the percentage of away wins' do
    expect(described_class.percentage_away_wins([game_1, game_2, game_3])).to eq(33.33)  
  end
end
