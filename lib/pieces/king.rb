# Chess validator
#
# Author:: Mikael Arvola

require 'piece'

module Chess
  class King < Piece
    moves_linear
    moves_diagonal
    moves_limit 1
    register "K"

  end
end