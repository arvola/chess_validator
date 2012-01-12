# Chess validator
#
# Author:: Mikael Arvola

require 'piece'

module Chess
  class Queen < Piece
    moves_linear
    moves_diagonal
    register "Q"

  end
end