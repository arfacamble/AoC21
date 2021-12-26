require_relative 'cucumbers'
data = parse(DATA)
example = parse(EXAMPLE)
baby = parse(BABY)

class CucumberMover
    def initialize(input)
        @start_time = Time.now
        @map = input[:map]
        @time = 0
        @height = input[:height]
        @width = input[:width]
        @moved_this_time = true
        # draw_map(@map)
        # puts '==============='
        # move
        # draw_map(@map)
        # puts '==============='
        # move
        # draw_map(@map)
        # puts '==============='
        # move
        # draw_map(@map)
        # puts '==============='
        until !@moved_this_time
            move
            @time += 1
            # puts "#{@time} moves so far"
        end
        puts "THEY'VE STOPPED MOOOVVIIIIIING!!!!!"
        puts "THEY TOOK BLOODY AGES (#{@time})"
        puts "In human time the duration of these movements was #{Time.now - @start_time}"
    end

    def move
        @moved_this_time = false
        move_right
        # draw_map(@map)
        move_left
        # puts '~~~~~~~~~~'
    end

    def move_right
        new_map = {}
        (0...@height).each { |y| new_map[y] = {} }
        @map.each do |y, row|
            row.each do |x, obj|
                if obj == 'v'
                    new_map[y][x] = obj
                elsif obj == '>'
                    coord = space_to_fill_right(y, x)
                    new_map[coord[0]][coord[1]] = obj
                end
            end
        end
        @map = new_map
    end

    def move_left
        new_map = {}
        (0...@height).each { |y| new_map[y] = {} }
        @map.each do |y, row|
            row.each do |x, obj|
                if obj == '>'
                    new_map[y][x] = obj
                elsif obj == 'v'
                    coord = space_to_fill_down(y, x)
                    new_map[coord[0]][coord[1]] = obj
                end
            end
        end
        @map = new_map
    end

    def space_to_fill_right(y, x)
        new_x = x + 1 == @width ? 0 : x + 1
        if space_full?(y, new_x)
            return y, x
        else
            @moved_this_time = true
            return y, new_x
        end
    end

    def space_to_fill_down(y, x)
        new_y = y + 1 == @height ? 0 : y + 1
        if space_full?(new_y, x)
            return y, x
        else
            @moved_this_time = true
            return new_y, x
        end
    end

    def space_full?(y, x)
        @map[y][x] != nil
    end

    def draw_map(map)
        (0...@height).each do |y|
            (0...@width).each { |x| print (obj = map[y][x]) ? obj : '.' }
            puts ' '
        end
    end
end

CucumberMover.new(data)