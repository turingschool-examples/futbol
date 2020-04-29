require "test_helper.rb"
require_relative "../lib/game_statistics.rb"

describe GameStatistics do
  let(:game) {GameStatistics.new}

  it "should exist" do
    expect(game).to be_kind_of(GameStatistics)
  end
end
