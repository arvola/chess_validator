# Chess validator
#
# Author:: Mikael Arvola

# This is an intermediary module that will
# include the nested MovementBase module in
# the class instance of whatever class includes
# Movement

require 'moves'

module Movement

  # Movement is going to be the same between all instances of
  # a pieces piece, so we want movement to be a "class instance"
  # feature rather than an instance feature. However, I prefer
  # to use a mixin because "movement" is potentially something
  # that is not unique to chess pieces
  def self.included(base)
    base.extend(MovementBase)
  end

  module MovementBase
    def moves
      # To declare an instance variable for the class
      # the module is included in and not the module,
      # we need to defined the array inside a method that
      # the class calls.
      @allowed_moves = @allowed_moves ? @allowed_moves : []
    end

    # These need to be called by the class and not an instance
    # of the class
    def moves_linear
      self.moves << Moves::MoveLinear.new
    end

    def moves_diagonal
      self.moves << Moves::MoveDiagonal.new
    end

    def moves_knight
      self.moves << Moves::MoveKnight.new
    end

    def moves_pawn
      self.moves << Moves::MovePawn.new
    end

    def moves_limit n
      self.moves << Moves::MoveLimit.new(n)
    end

    # This piece can move through other pieces. For chess, it's
    # the knight
    def moves_through!
      @moves_through = true
    end

    def moves_through?
      @moves_through ? @moves_through : false
    end
  end
end
