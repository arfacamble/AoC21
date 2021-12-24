class DiracPlayer
    def initialize(start_1, start_2)
        @pos = [nil, start_1, start_2]
        @score = [nil, 0, 0]
        @next_roll = 1
        @roll_count = 0
        @turn_1 = true
        play
    end

    def play
        until @score[1] >=1000 or @score[2] >= 1000
            score_d = @next_roll * 3 + 3
            die_inc_3
            player = @turn_1 ? 1 : 2
            score = (@pos[player] + score_d) % 10
            score = score == 0 ? 10 : score
            @pos[player] = score
            @score[player] += score
            @turn_1 = !@turn_1
            puts "player 1: #{@score[1]} --- player 2: #{@score[2]} --- roll count: #{@roll_count}"
        end

    end

    def die_inc_3
        @next_roll = (@next_roll + 3) % 100
        @roll_count += 3
    end
end

DiracPlayer.new(4, 10)