class MinHeap
    attr_reader :array
    def initialize(seed = [])
        @array = seed
    end

    def fix_error(index)
        return if leaf_node?(index) || happy_node?(index)
        
    end

    def leaf_node?(index)
        index >= (@array.size)/2
    end

    def happy_node?(index)
        val = @array[index]
        val >= parent(index) && val <= left_child(index) && val <= right_child(index)
    end

    def parent(index)
        @array[parent_index(index)]
    end

    def left_child(index)
        @array[left_child_index(index)]
    end

    def right_child(index)
        @array[right_child_index(index)]
    end

    def left_child_index(index)
        2 * index + 1
    end

    def right_child_index(index)
        2 * index + 2
    end

    def parent_index(index)
        (index - 1) / 2
    end
end

# TODO - test performance change where array size tracked manually