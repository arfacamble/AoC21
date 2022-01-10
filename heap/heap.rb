class Heap
    attr_reader :heap, :hashmap

    def initialize(compare_symbol = :<, storage = [], &compare_fn)
      @heap = storage
      @size = 0
      @hashmap = {}
      initialize_compare(compare_symbol, &compare_fn)
    end
  
    attr_reader :size
  
    def empty?
      size == 0
    end
  
    def peak
      @heap[0]
    end
  
    def pop
      result = peak

      if size > 1
        @heap[0] = @heap[-1]
        new_top_id = @heap[0][:id]
        @hashmap[new_top_id] = 0
      end

      @size -= 1 unless @size == 0
      id_to_delete = result[:id]
      @heap.delete_at(-1)
      @hashmap.delete(id_to_delete)

      # puts "index of #{new_top_coord} according to map = #{@hashmap[new_top_coord]}"
      # puts "index of #{coord_to_delete} according to map = #{@hashmap[coord_to_delete]}"

      rebalance_down(0) if @size > 0

      result
    end

    def print_heap
      line_width = 1
      line_count = 0
      @heap.each do |node|
        print node[:cost]
        line_count += 1
        if line_count == line_width
            line_width *= 2
            line_count = 0
            puts ''
        end
      end
      puts "\n"
    end
  
    def add(element)
      @heap << element
      @hashmap[element[:id]] = @size
      @size += 1
      rebalance_up(@size - 1)
      self
    end
  
    alias :<< :add
  
    def replace(element)
      @heap[0] = element
      rebalance_down(0)
    end
  
    def offer(element)
      if compare(peak, element)
        result = peak
        replace(element)
        result
      else
        element
      end
    end

    def offer_at(i, element)
      # puts "should we be here? #{element[:coord] == @heap[i][:coord]}"
      # puts "offer_at - index: #{i} - new: #{element} - old: #{@heap[i]} - swap? #{compare(element, @heap[i])}"
      if compare(element, @heap[i])
        @heap[i] = element
        rebalance_up(i)
        rebalance_down(i)
      end
    end
  
    def clear
      @heap = []
      @size = 0
    end
  
    def to_a
      @heap.reject{|element| element.nil? }
    end

    # def find_node_and_i(coord)
    #     i = @heap.index { |n| n[:coord] == coord }
    #     return i, @heap[i]
    # end
  
    private
  
    def initialize_compare(symbol, &fn)
      @compare = if block_given?
        fn
      elsif symbol == :< or symbol.nil?
        lambda{|a, b| a < b}
      elsif symbol == :>
        lambda{|a, b| a > b}
      else
        raise ArgumentError.new("The comparison symbol needs to be either :> or :<")
      end
    end
  
    def compare(a, b)
      @compare.call(a, b)
    end
  
    def rebalance_up(i)
      parent_i = parent(i)
      # puts '--------------- rebalance_up ---------------' unless @size < 249990
      # puts "parent: #{@heap[parent_i]}" unless @size < 249990
      # puts "child: #{@heap[i]}" unless @size < 249990
      # puts "swap? #{compare(@heap[i], @heap[parent_i])}" unless @size < 249990
  
      if has_parent(i) and compare(@heap[i], @heap[parent_i])
        child_id = @heap[i][:id]
        parent_id = @heap[parent_i][:id]
        # puts "INITIAL - Parent index in map: #{@hashmap[parent_id]}" unless @size < 249990
        # puts "INITIAL - Child index in map: #{@hashmap[child_id]}" unless @size < 249990
        @heap[i], @heap[parent_i] = @heap[parent_i], @heap[i]
        @hashmap[child_id] = parent_i
        @hashmap[parent_id] = i
        # puts "INITIAL - Parent index in map: #{@hashmap[parent_coord]}" unless @size < 249990
        # puts "INITIAL - Child index in map: #{@hashmap[child_coord]}" unless @size < 249990
        rebalance_up(parent_i) if has_parent(parent_i)
      end
    end
  
    def rebalance_down(i)
      left_i = left(i)
      right_i = right(i)

      # puts "rebalance_down - index: #{i} - element: #{@heap[i]} - element cost: #{@heap[i][:route_cost]} - right cost: #{@heap[right_i][:route_cost]} - left cost: #{@heap[left_i][:route_cost]}"
      
      parent_id = @heap[i][:id]
      if has_left(i) and compare(@heap[left_i], @heap[i]) and (not has_right(i) or compare(@heap[left_i], @heap[right_i]))
        child_id = @heap[left_i][:id]
        @heap[i], @heap[left_i] = @heap[left_i], @heap[i]
        @hashmap[child_id] = i
        @hashmap[parent_id] = left_i
        rebalance_down(left_i)
      elsif has_right(i) and compare(@heap[right_i], @heap[i])
        child_id = @heap[right_i][:id]
        @heap[i], @heap[right_i] = @heap[right_i], @heap[i]
        @hashmap[child_id] = i
        @hashmap[parent_id] = right_i
        rebalance_down(right_i)
      end
    end
  
    def has_parent(i)
      i >= 1
    end
  
    def parent(i)
      ((i - 1) / 2).floor
    end
  
    def has_left(i)
      left(i) < size
    end
  
    def left(i)
      i * 2 + 1
    end
  
    def has_right(i)
      right(i) < size
    end
  
    def right(i)
      i * 2 + 2
    end
  end