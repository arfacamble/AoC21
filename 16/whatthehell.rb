hex_map = {
    '0': '0000',
    '1': '0001',
    '2': '0010',
    '3': '0011',
    '4': '0100',
    '5': '0101',
    '6': '0110',
    '7': '0111',
    '8': '1000',
    '9': '1001',
    'A': '1010',
    'B': '1011',
    'C': '1100',
    'D': '1101',
    'E': '1110',
    'F': '1111'
}

example1 = 'D2FE28'
example2 = '38006F45291200'

bit_input = example2.chars.map { |key| hex_map[key.to_sym].chars }.flatten

class NonsenseDecoder
    def initialize(bit_input, hex_map)
        @hex_map = hex_map
        @bits_left = bit_input
        @packet_versions = []
        set_packet_version_and_type_id
        @final_bits = []
        @length_type_id = nil
        if @type_id == '4'
            literally
        else
            operator
        end
        @final_num = convert_bin_to_num(@final_bits)
        p @final_num
    end

    def set_packet_version_and_type_id
        packet_version = [ 0 ]
        3.times { packet_version << @bits_left.shift }
        @packet_version = @hex_map.key(packet_version.join).to_s
        @packet_versions << @packet_version.to_i
        type_id = [ 0 ]
        3.times { type_id << @bits_left.shift }
        @type_id = @hex_map.key(type_id.join).to_s
    end

    def return
        {
            packet_versions: @packet_versions,
            final_num: @final_num,
            bits_left: @bits_left
        }
    end

    def operator
        @length_type_id = @bits_left.shift
        if @length_type_id == '0'
            @sub_packets_bit_length = convert_bin_to_num(@bits_left.shift(15))
            @sub_packets_bit_length
            sub_packets = @bits_left.shift(@sub_packets_bit_length)
            sub = NonsenseDecoder.new(sub_packets, @hex_map)
            until sub.return[:bits_left].empty?
                @packet_versions += sub.return[:packet_versions]
                sub = NonsenseDecoder.new(sub.return[:bits_left], @hex_map)
            end
            sub.return
        elsif @length_type_id == '1'
            puts 'bla bla bla'
        end
    end

    def convert_bin_to_num(bits)
        num = 0
        bits.reverse.each_with_index do |bit, i|
            num += bit.to_i * 2**i
        end
        num
    end

    def literally
        @bits_left.each_slice(5) do |slice|
            first = slice.shift
            if first == '1'
                @final_bits += slice
            elsif first == '0'
                @final_bits += slice
                break
            end
        end
    end
end

p NonsenseDecoder.new(bit_input, hex_map)

