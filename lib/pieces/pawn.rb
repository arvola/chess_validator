# Chess validator
#
# Author:: Mikael Arvola

require 'piece'

module Chess
  class Pawn < Piece
    moves_pawn
    register "P"

  end
end