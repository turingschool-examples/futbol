class Game
    attr_reader :game_id,
                :season,
                :type,
                :date_time

    def initialize(info)
        @game_id = info["game_id"]
        @season = info["season"]
        @type = info["type"]
        @date_time = info["date_time"]
    end
end