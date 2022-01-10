require_relative 'parse'
require_relative 'snail_calculator'

class MegaMagnitude
    attr_reader :max_magnitude

    def initialize(nums)
        @nums = nums
        @max_magnitude = 0
        @nums.each_with_index do |n_1, i|
            @nums.each_with_index do |n_2, j|
                next if i == j
                magnitude = SnailCalculator.new([n_1, n_2]).magnitude
                @max_magnitude = magnitude if magnitude > @max_magnitude
            end    
        end
    end
end

start_time = Time.now

# input = parse(EXAMPLE)
input = parse(DATA)

puts "top magnitude = #{MegaMagnitude.new(input).max_magnitude}"

puts "Duration: #{Time.now - start_time} seconds"

# top magnitude = 4735
# Duration: 2.9105954 seconds