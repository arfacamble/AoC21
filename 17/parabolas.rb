require_relative 'output'

example = { x: 20..30, y: -10..-5 }
data = { x: 209..238, y: -86..-59 }

class VelFinder
    attr_reader :x_vel_step_pairs, :x_vel_step_pair_infinites, :y_vel_step_pairs, :vel_combos

    def initialize(target)
        @x_target = target[:x]
        @x_vel_step_pairs = []
        @x_vel_step_pair_infinites = []
        find_x_vel_step_pairs
        @y_target = target[:y]
        @y_vel_step_pairs = []
        find_y_vel_step_pairs
        @vel_combos = []
        find_vel_combos
        # p @vel_combos
        p @vel_combos.uniq.size
    end

    def find_vel_combos
        @y_vel_step_pairs.each do |y_pair|
            # p '-------------------'
            @x_vel_step_pairs.filter { |x_pair| x_pair[:steps] == y_pair[:steps] }
                             .each { |x_pair| @vel_combos << [x_pair[:start_vel], y_pair[:start_vel]] }
            @x_vel_step_pair_infinites.each { |x_infinite| @vel_combos << [x_infinite[:start_vel], y_pair[:start_vel]] if y_pair[:steps] >= x_infinite[:min_step] }
        end
    end

    def find_x_vel_step_pairs
        start_vel = 1
        until start_vel > @x_target.max
            x_coords = [ 0 ]
            vel = start_vel
            next_stop = x_coords[-1] + vel
            until next_stop > @x_target.max || vel == 0
                x_coords << next_stop
                vel -= 1 unless vel == 0
                if @x_target.include?(x_coords[-1])
                    @x_vel_step_pairs << { start_vel: x_coords[1] - x_coords[0], steps: x_coords.size - 1 }
                    if vel == 0
                        @x_vel_step_pair_infinites << { start_vel: x_coords[1] - x_coords[0], min_step: x_coords.size }
                    end
                end
                next_stop = x_coords[-1] + vel
            end
            start_vel += 1
        end
    end

    def find_y_vel_step_pairs
        start_vel = @y_target.min
        until start_vel == @y_target.min.abs
            y_coords = [ 0 ]
            vel = start_vel
            next_stop = y_coords[-1] + vel
            until next_stop < @y_target.min
                y_coords << next_stop
                vel -= 1
                if @y_target.include?(y_coords[-1])
                    @y_vel_step_pairs << { start_vel: y_coords[1] - y_coords[0], steps: y_coords.size - 1 }
                end
                next_stop = y_coords[-1] + vel
            end
            start_vel += 1
        end
    end
end

thing = VelFinder.new(data)
# p thing.x_vel_step_pairs
# p thing.x_vel_step_pair_infinites
# p thing.y_vel_step_pairs
my_answer = thing.vel_combos
answer = ANSWER
# p my_answer.intersection(answer)
# p my_answer - answer
# p answer - my_answer