require_relative 'cuboid'

class Overlapper
    attr_reader :overlap, :overlaps, :to_do, :original_minus_overlap

    def initialize(input)
        @original = input[:original]    # a Cuboid
        @change = input[:change]        # a Cuboid
        @on = input[:switch] == 'on'
        @off = !@on
        @overlaps = false
        @overlap = {}
        find_overlap(:x)
        return unless @overlap[:x]
        find_overlap(:y)
        return unless @overlap[:y]
        find_overlap(:z)
        return unless @overlap[:z]
        @overlap = Cuboid.new(overlap)
        @overlaps = true
        # find todos = change - overlap
        @to_do = subtract_internal_cuboid(@change, @overlap)
        return if @on
        # find original_minus_overlap = original - overlap
        @original_minus_overlap = subtract_internal_cuboid(@original, @overlap)
    end

    def find_overlap(dim)
        change = @change.send(dim)
        change_min = change.first
        change_max = change.last
        original = @original.send(dim)
        left_on_right = change_min <= original.last ? 'less' : 'more'
        return if left_on_right == 'more'
        right_on_left = change_max >= original.first ? 'more' : 'less'
        return if right_on_left == 'less'
        left_inside = original.include?(change_min)
        right_inside = original.include?(change_max)
        if left_inside && right_inside
            @overlap[dim] = change
            return
        elsif !left_inside && !right_inside
            @overlap[dim] = original
        elsif !left_inside
            @overlap[dim] = original.first..change_max
        else
            @overlap[dim] = change_min..original.last
        end
    end

    def subtract_internal_cuboid(big_c, small_c)
        big_c = Cuboid.new(big_c.dimensions)
        extras = []
        remaining = []
        %i(x y z).each do |dim|
            range_subtract(big_c.send(dim), small_c.send(dim)).each { |range| extras << { dimension: dim, range: range } }
        end
        extras.sort_by! { |e| e[:range].size }
        until extras.empty?
            cut_thing = extras.pop
            dimension = cut_thing[:dimension]
            cut_range = cut_thing[:range]
            extra = big_c.dimensions
            extra[dimension] = cut_range
            remaining << Cuboid.new(extra)
            new_big_c_range = range_subtract(big_c.send(dimension), cut_range).first
            big_c.send((dimension.to_s + '=').to_sym, new_big_c_range)
        end
        remaining
    end

    def range_subtract(big_r, small_r)
        if big_r == small_r
            []
        elsif big_r.first == small_r.first
            [(small_r.last + 1)..big_r.last]
        elsif big_r.last == small_r.last
            [big_r.first..(small_r.first - 1)]
        else
            [
                big_r.first..(small_r.first - 1),
                (small_r.last + 1)..big_r.last
            ]
        end
    end

    def clone_hash(hash)
        Marshal.load(Marshal.dump(hash))
      end      
end
