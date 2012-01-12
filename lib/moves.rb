# Chess validator
#
# Author:: Mikael Arvola

# Moves should have a method called 'valid?' that returns
# true, false or nil. If true, the move is valid for this
# movement type. If false, it is not valid. If nil, the rule
# overrides any other rules and makes this entire move invalid.
#
# Moves can also assume that the piece actually moved, so at
# least one axis had a change.

module Moves

  # Object to represent a move, with piece being the chess
  # piece that's moving. Can optionally set a target if the
  # square being moved to contains another chess piece
  class Move
    attr_accessor :x, :y, :x2, :y2, :piece, :target

    def initialize x = 0, y = 0, x2 = 0, y2 = 0
      @x = x
      @y = y
      @x2 = x2
      @y2 = y2
    end

    def x_delta
      @x2 - @x
    end

    def y_delta
      # To simplify moves, invert Y axis for black pieces
      @piece.color == :white ? @y2 - @y : @y - @y2
    end

    # Inversion for Y when used by Move classes
    def get_y
      @piece.color == :white ? @y : 7 - @y
    end

    def get_y2
      @piece.color == :white ? @y2 : 7 - @y2
    end

    def valid?
      return false unless @piece
      return false if @target && @target.color == @piece.color

      @piece.validate_move self
    end
  end

  class MoveLinear
    def valid? move
      !(move.x_delta !=0 && move.y_delta != 0)
    end
  end

  class MoveDiagonal
    def valid? move
      move.x_delta.abs == move.y_delta.abs
    end
  end

  class MoveLimit

    # Move limit is potentially variable, even though chess
    # doesn't really use limits other than 1
    def initialize limit
      @limit = limit
    end

    def valid? move
      if (move.x_delta.abs > @limit || move.y_delta.abs > @limit)
        nil
      else
        true
      end
    end
  end

  class MoveKnight
    def valid? move
      move.x_delta**2 + move.y_delta**2 == 5
    end
  end

  class MovePawn
    def valid? move
      if (move.x_delta == 0)
        move.y_delta == 1 || move.y_delta == 2 && move.get_y == 1
      elsif (move.x_delta.abs == 1 && move.y_delta == 1 && move.target)
        true
      else
        false
      end
    end
  end
end