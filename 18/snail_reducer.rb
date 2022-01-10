class SnailReducer
    attr_reader :num

    def initialize(num)
        @num = num
        @explode_time = true
        @split_time = true
        until !@explode_time && !@split_time
            @explode_time ? explode : split
        end
    end

    def explode
        depth = 0
        last_num_i = nil
        @num.each_with_index do |char, i|
            if char.is_a? Integer
                last_num_i = i
            elsif char == '['
                depth += 1
            elsif char == ']'
                depth -= 1
            end
            if depth == 5
                first_num = @num[i+1]
                second_num = @num[i+2]
                @num[last_num_i] += first_num if last_num_i
                next_num_i = @num[i+3..].index { |char| char.is_a? Integer }
                next_num_i += (i + 3) if next_num_i
                @num[next_num_i] += second_num if next_num_i
                @num.slice!(i, 4)
                @num.insert(i, 0)
                return
            end
        end
        @explode_time = false
        @split_time = true
    end

    def split
        @split_time = false
        @num.each_with_index do |char, i|
            if char.is_a?(Integer) && char >= 10
                first_num = char / 2
                second_num = char.even? ? first_num : first_num + 1
                @num.delete_at(i)
                @num.insert(i, '[', first_num, second_num, ']')
                @explode_time = true
                return
            end
        end
    end
end

# require_relative 'parse'
# num_1 = convert('[[[[[9,8],1],2],3],4]')
# expected_1 = convert('[[[[0,9],2],3],4]')

# num_2 = convert('[7,[6,[5,[4,[3,2]]]]]')
# expected_2 = convert('[7,[6,[5,[7,0]]]]')

# num_3 = convert('[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]')
# expected_3 = convert('[[3,[2,[8,0]]],[9,[5,[7,0]]]]')

# num_4 = convert('[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]')
# expected_4 = convert('[[[[0,7],4],[[7,8],[6,0]]],[8,1]]')

# res_1 = SnailReducer.new(num_1).num
# puts "Test 1: #{res_1 == expected_1 ? 'Passed' : 'Failed'}"
# puts "Result:   #{res_1}"
# puts "Expected: #{expected_1}"
# puts "======================================================="

# res_2 = SnailReducer.new(num_2).num
# puts "Test 2: #{res_2 == expected_2 ? 'Passed' : 'Failed'}"
# puts "Result:   #{res_2}"
# puts "Expected: #{expected_2}"
# puts "======================================================="

# res_3 = SnailReducer.new(num_3).num
# puts "Test 3: #{res_3 == expected_3 ? 'Passed' : 'Failed'}"
# puts "Result:   #{res_3}"
# puts "Expected: #{expected_3}"
# puts "======================================================="

# # puts "Actual Steps:"
# res_4 = SnailReducer.new(num_4).num
# puts "Test 4: #{res_4 == expected_4 ? 'Passed' : 'Failed'}"
# # puts "\nExpected Steps:"
# # p convert('[[[[0,7],4],[7,[[8,4],9]]],[1,1]]')
# # p convert('[[[[0,7],4],[15,[0,13]]],[1,1]]')
# # p convert('[[[[0,7],4],[[7,8],[0,13]]],[1,1]]')
# # p convert('[[[[0,7],4],[[7,8],[0,[6,7]]]],[1,1]]')
# puts "Result:   #{res_4}"
# puts "Expected: #{expected_4}"
# puts "======================================================="
