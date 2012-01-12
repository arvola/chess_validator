# Chess validator
#
# Author:: Mikael Arvola

require 'piece'

module Chess
  class Bishop < Piece
    moves_diagonal
    register "B"

  end
end