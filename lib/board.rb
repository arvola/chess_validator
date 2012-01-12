# Chess validator
#
# Author:: Mikael Arvola

module Chess
  class Board
    # Does not check formatting or validity
    def self.map! pieces
      pieces.map! do |v|
        if v == "--"
          nil
        else
          color = v[0] == 'b' ? :black : :white
          piece = Chess.registry[v[1]]
          piece.new color
        end
      end
    end

    def self.from_text board_text
      pieces = []
      board_text.scan(/([bw][PRNBQK]|--) ?/) { |v| pieces << v[0] }

      if pieces.length == 64
        # Turn our list into an 8x8 multi-dimensional array

        map! pieces

        board_arrays = []

        # Pop inverses the order to chess notation
        8.times { |i| board_arrays << pieces.pop(8) }

        # Store location with the piece as well
        board_arrays.each_with_index do |ar, i|
          ar.each_with_index do |o, j|
            next if o.nil?
            o.x = j
            o.y = i
          end
        end

        Board.new board_arrays
      else
        nil
      end
    end

    def initialize board
      @board = board
    end

    def find x, y
      # Rows first due to how files are organized
      @board[y][x]
    end

    alias :[] :find

    def path_empty? x, y, x2, y2
      x_delta = x2 - x
      y_delta = y2 - y
      ([x_delta.abs, y_delta.abs].max - 1).times do |i|
        # Dividing delta with its own abs gives us either 1 or -1, as long as it's not zero
        if find(x + (x_delta != 0 ? (x_delta / x_delta.abs)*(i+1) : 0), y + (y_delta != 0 ? (y_delta / y_delta.abs)*(i+1) : 0))
          return false
        end
      end
      true
    end

    def pieces
      @board.flatten.compact
    end
  end
end