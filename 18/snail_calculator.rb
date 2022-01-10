require_relative 'snail_reducer'
require_relative 'magnitude_finder'

class SnailCalculator
    attr_reader :total, :magnitude

    def initialize(nums)
        @nums = nums
        @total = @nums.shift
        until nums.empty?
            @total = add(@total, @nums.shift)
        end
        mag = MagnitudeFinder.new(total)
        @magnitude = mag.magnitude
    end

    def add(num_1, num_2)
        new_num = ['['] + num_1 + num_2 + [']']
        @total = SnailReducer.new(new_num).num
    end
end

# require_relative 'parse'

# start_time = Time.now
# # input = parse(EXAMPLE)
# input = parse(DATA)

# p SnailCalculator.new(input).magnitude
# puts "Duration: #{Time.now - start_time} seconds"

# ANSWER 3699 for real data

# eg_1 = parse('[1,1]
# [2,2]
# [3,3]
# [4,4]')
# exp_1 = convert('[[[[1,1],[2,2]],[3,3]],[4,4]]')

# eg_2 = parse('[1,1]
# [2,2]
# [3,3]
# [4,4]
# [5,5]')
# exp_2 = convert('[[[[3,0],[5,3]],[4,4]],[5,5]]')

# eg_3 = parse('[1,1]
# [2,2]
# [3,3]
# [4,4]
# [5,5]
# [6,6]')
# exp_3 = convert('[[[[5,0],[7,4]],[5,5]],[6,6]]')

# eg_4 = parse('[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]
# [7,[[[3,7],[4,3]],[[6,3],[8,8]]]]
# [[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]
# [[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]
# [7,[5,[[3,8],[1,4]]]]
# [[2,[2,2]],[8,[8,1]]]
# [2,9]
# [1,[[[9,3],9],[[9,0],[0,7]]]]
# [[[5,[7,4]],7],1]
# [[[[4,2],2],6],[8,7]]')
# exp_4 = convert('[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]')

# res_1 = SnailCalculator.new(eg_1).total
# puts "Test 1: #{res_1 == exp_1 ? 'Passed' : 'Failed'}"
# puts "Result:   #{res_1}"
# puts "Expected: #{exp_1}"
# puts "======================================================="

# res_2 = SnailCalculator.new(eg_2).total
# puts "Test 2: #{res_2 == exp_2 ? 'Passed' : 'Failed'}"
# puts "Result:   #{res_2}"
# puts "Expected: #{exp_2}"
# puts "======================================================="

# res_3 = SnailCalculator.new(eg_3).total
# puts "Test 3: #{res_3 == exp_3 ? 'Passed' : 'Failed'}"
# puts "Result:   #{res_3}"
# puts "Expected: #{exp_3}"
# puts "======================================================="

# res_4 = SnailCalculator.new(eg_4).total
# puts "Test 4: #{res_4 == exp_4 ? 'Passed' : 'Failed'}"
# puts "Result:   #{res_4}"
# puts "Expected: #{exp_4}"
