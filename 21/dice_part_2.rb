class DiracPlayer
    def initialize(start_1, start_2)
        @games = [
            {
                count: 1,
                state: {
                    pos_1: start_1,
                    pos_2: start_2,
                    score_1: 0,
                    score_2: 0
                }
            }
        ]
        @turn_1 = true
        @wins_1 = 0
        @wins_2 = 0
        play
    end

    def play
        until @games.empty?
            new_game_states = []
            # iterate over games
            @games.each do |game|
                # map each game_state to new game states taking count into account
                new_games = @turn_1 ? map_game_1(game) : map_game_2(game)
                new_games.each do |new_game|
                    if new_game[:state][:score_1] > 20
                        @wins_1 += new_game[:count]
                    elsif new_game[:state][:score_2] > 20
                        @wins_2 += new_game[:count]
                    else
                        match = new_game_states.find { |nugame| nugame[:state] == new_game[:state] }
                        if match
                            match[:count] += new_game[:count]
                        else
                            new_game_states << new_game
                        end
                    end
                end
            end
            @games = new_game_states
            @turn_1 = !@turn_1
            p self
        end
    end

    def map_game_1(game)
        new_games = []

        new_pos = new_pos(game[:state][:pos_1], 3)
        new_games << {
            count: game[:count] * 1,
            state: {
                pos_1: new_pos,
                pos_2: game[:state][:pos_2],
                score_1: game[:state][:score_1] + new_pos,
                score_2: game[:state][:score_2]
            }
        }

        new_pos = new_pos(game[:state][:pos_1], 4)
        new_games << {
            count: game[:count] * 3,
            state: {
                pos_1: new_pos,
                pos_2: game[:state][:pos_2],
                score_1: game[:state][:score_1] + new_pos,
                score_2: game[:state][:score_2]
            }
        }

        new_pos = new_pos(game[:state][:pos_1], 5)
        new_games << {
            count: game[:count] * 6,
            state: {
                pos_1: new_pos,
                pos_2: game[:state][:pos_2],
                score_1: game[:state][:score_1] + new_pos,
                score_2: game[:state][:score_2]
            }
        }

        new_pos = new_pos(game[:state][:pos_1], 6)
        new_games << {
            count: game[:count] * 7,
            state: {
                pos_1: new_pos,
                pos_2: game[:state][:pos_2],
                score_1: game[:state][:score_1] + new_pos,
                score_2: game[:state][:score_2]
            }
        }

        new_pos = new_pos(game[:state][:pos_1], 7)
        new_games << {
            count: game[:count] * 6,
            state: {
                pos_1: new_pos,
                pos_2: game[:state][:pos_2],
                score_1: game[:state][:score_1] + new_pos,
                score_2: game[:state][:score_2]
            }
        }

        new_pos = new_pos(game[:state][:pos_1], 8)
        new_games << {
            count: game[:count] * 3,
            state: {
                pos_1: new_pos,
                pos_2: game[:state][:pos_2],
                score_1: game[:state][:score_1] + new_pos,
                score_2: game[:state][:score_2]
            }
        }

        new_pos = new_pos(game[:state][:pos_1], 9)
        new_games << {
            count: game[:count] * 1,
            state: {
                pos_1: new_pos,
                pos_2: game[:state][:pos_2],
                score_1: game[:state][:score_1] + new_pos,
                score_2: game[:state][:score_2]
            }
        }

        new_games
    end

    
    def map_game_2(game)
        new_games = []

        new_pos = new_pos(game[:state][:pos_2], 3)
        new_games << {
            count: game[:count] * 1,
            state: {
                pos_1: game[:state][:pos_1],
                pos_2: new_pos,
                score_1: game[:state][:score_1],
                score_2: game[:state][:score_2] + new_pos
            }
        }

        new_pos = new_pos(game[:state][:pos_2], 4)
        new_games << {
            count: game[:count] * 3,
            state: {
                pos_1: game[:state][:pos_1],
                pos_2: new_pos,
                score_1: game[:state][:score_1],
                score_2: game[:state][:score_2] + new_pos
            }
        }

        new_pos = new_pos(game[:state][:pos_2], 5)
        new_games << {
            count: game[:count] * 6,
            state: {
                pos_1: game[:state][:pos_1],
                pos_2: new_pos,
                score_1: game[:state][:score_1],
                score_2: game[:state][:score_2] + new_pos
            }
        }

        new_pos = new_pos(game[:state][:pos_2], 6)
        new_games << {
            count: game[:count] * 7,
            state: {
                pos_1: game[:state][:pos_1],
                pos_2: new_pos,
                score_1: game[:state][:score_1],
                score_2: game[:state][:score_2] + new_pos
            }
        }

        new_pos = new_pos(game[:state][:pos_2], 7)
        new_games << {
            count: game[:count] * 6,
            state: {
                pos_1: game[:state][:pos_1],
                pos_2: new_pos,
                score_1: game[:state][:score_1],
                score_2: game[:state][:score_2] + new_pos
            }
        }

        new_pos = new_pos(game[:state][:pos_2], 8)
        new_games << {
            count: game[:count] * 3,
            state: {
                pos_1: game[:state][:pos_1],
                pos_2: new_pos,
                score_1: game[:state][:score_1],
                score_2: game[:state][:score_2] + new_pos
            }
        }

        new_pos = new_pos(game[:state][:pos_2], 9)
        new_games << {
            count: game[:count] * 1,
            state: {
                pos_1: game[:state][:pos_1],
                pos_2: new_pos,
                score_1: game[:state][:score_1],
                score_2: game[:state][:score_2] + new_pos
            }
        }

        new_games
    end

    def new_pos(pos, score)
        pos = pos + score
        pos -= 10 if pos > 10
        pos
    end
end
start_time = Time.now
p DiracPlayer.new(4, 10)
puts "Duration: #{Time.now - start_time}"
