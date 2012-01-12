# Chess validator
#
# Author:: Mikael Arvola

require 'piece'

module Chess
  class Rook < Piece
    moves_linear
    register "R"

  end
end