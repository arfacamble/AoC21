example1 = [[1,1],
[2,2],
[3,3],
[4,4]]
example2 = [[1,1],
[2,2],
[3,3],
[4,4],
[5,5]]
example3 = [[1,1],
[2,2],
[3,3],
[4,4],
[5,5],
[6,6]]
example4 = [[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]],
[7,[[[3,7],[4,3]],[[6,3],[8,8]]]],
[[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]],
[[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]],
[7,[5,[[3,8],[1,4]]]],
[[2,[2,2]],[8,[8,1]]],
[2,9],
[1,[[[9,3],9],[[9,0],[0,7]]]],
[[[5,[7,4]],7],1],
[[[[4,2],2],6],[8,7]]]

class SnailAddTwo
    attr_reader :answer

    def initialize(num1, num2)
        @answer = [num1, num2]
        reduce
    end

    def reduce
        until no_fourth_nesting && no_double_digits
            unless no_fourth_nesting
                explode
            end
            unless no_double_digits
                split
            end
        end
    end

    def explode

    end

    def no_fourth_nesting
        @answer.flatten(3) == @answer.flatten
    end

    def no_double_digits
        @answer.flatten.none? { |num| num > 9 }
    end
end

class SnailAddMany
    attr_reader :numbers, :answer

    def initialize(input)
        @numbers = input
        @answer
        compoot
    end

    def compoot
        until @numbers.empty?
            @answer = @numbers.shift if @answer.nil?
            add_two = SnailAddTwo.new(@answer, @numbers.shift)
            @answer = add_two.answer
        end
    end
end

thing =  SnailAddMany.new(example2)
# thing.numbers.each { |num| p num }
p thing.answer