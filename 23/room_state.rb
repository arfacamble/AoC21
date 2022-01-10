class RoomState
    attr_reader :id, :cost, :state

    def initialize(input)
        @cost = input[:cost]
        @id = input[:id]
        @state = {}
        if input[:state]
            @state = input[:state]
        else
            generate_state
        end
        generate_id unless @id
    end

    def complete?
        state.all? do |pos, val|
            if pos.to_s[0].upcase == 'A'
                val == 'A'
            elsif pos.to_s[0].upcase == 'B'
                val == 'B'
            elsif pos.to_s[0].upcase == 'C'
                val == 'C'
            elsif pos.to_s[0].upcase == 'D'
                val == 'D'
            else
                true
            end
        end
    end

    def generate_id
        @id = "h1=#{@state[:h1]}_h2=#{@state[:h2]}_h3=#{@state[:h3]}_h4=#{@state[:h4]}_h5=#{@state[:h5]}_h6=#{@state[:h6]}_h7=#{@state[:h7]}_h8=#{@state[:h8]}_h9=#{@state[:h_]}_h10=#{@state[:h10]}_h11=#{@state[:h11]}_a1=#{@state[:a1]}_a2=#{@state[:a2]}_a3=#{@state[:a3]}_a4=#{@state[:a4]}_b1=#{@state[:b1]}_b2=#{@state[:b2]}_b3=#{@state[:b3]}_b4=#{@state[:b4]}_c1=#{@state[:c1]}_c2=#{@state[:c2]}_c3=#{@state[:c3]}_c4=#{@state[:c4]}_d1=#{@state[:d1]}_d2=#{@state[:d2]}_d3=#{@state[:d3]}_d4=#{@state[:d4]}".to_sym
    end

    def generate_state
        @id.to_s.split('_').each do |pos_and_amp|
            pos, amp = pos_and_amp.split('=')
            @state[pos.to_sym] = amp unless amp ==''
        end
    end

    def printable_state
        printable_state = []
        cost = "Cost: #{@cost}"
        cost += ' ' until cost.size >= 11
        printable_state << cost
        printable_state << '-----------'
        hallway = ''
        (:h1..:h9).each { |pos| hallway += (a = @state[pos]) ? a : ' ' }
        (:h10..:h11).each { |pos| hallway += (a = @state[pos]) ? a : ' ' }
        printable_state << hallway
        row = '--'
        %i(a1 b1 c1 d1).each { |pos| row += (a = @state[pos]) ? "#{a}-" : ' -' }
        row += '-'
        printable_state << row
        row = '--'
        %i(a2 b2 c2 d2).each { |pos| row += (a = @state[pos]) ? "#{a}-" : ' -' }
        row += '-'
        printable_state << row
        row = '--'
        %i(a3 b3 c3 d3).each { |pos| row += (a = @state[pos]) ? "#{a}-" : ' -' }
        row += '-'
        printable_state << row
        row = '--'
        %i(a4 b4 c4 d4).each { |pos| row += (a = @state[pos]) ? "#{a}-" : ' -' }
        row += '-'
        printable_state << row
        printable_state << '-----------'
        printable_state    
    end
end

# holds positions in @state                 /
# gives out id as symbol                   /
# gives printable version                   /
# can be created with a id or a state      /

start_input = {
    cost: 0,
    state: {
        h1:  nil,
        h2:  nil,
        h3:  nil,
        h4:  nil,
        h5:  nil,
        h6:  nil,
        h7:  nil,
        h8:  nil,
        h9:  nil,
        h10: nil,
        h11: nil,
        a1:  'D',
        a2:  'D',
        a3:  'D',
        a4:  'D',
        b1:  'B',
        b2:  'C',
        b3:  'B',
        b4:  'A',
        c1:  'C',
        c2:  'B',
        c3:  'A',
        c4:  'B',
        d1:  'C',
        d2:  'A',
        d3:  'C',
        d4:  'A',
    }
}

# start_state = RoomState.new(start_input)
# p start_state.id
# puts start_state.printable_state
# p start_state.printable_state

other_start_input = {
    cost: 0,
    id: :"h1=_h2=_h3=_h4=_h5=_h6=_h7=_h8=_h9==_h10==_h11=_a1=D_a2=D_a3=D_a4=D_b1=B_b2=C_b3=B_b4=A_c1=C_c2=B_c3=A_c4=B_d1=C_d2=A_d3=C_d4=A"
}
# other_start_state = RoomState.new(other_start_input)
# p other_start_state.id
# puts other_start_state.printable_state