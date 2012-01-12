# Chess validator
#
# Author:: Mikael Arvola

require 'piece'

module Chess
  class Knight < Piece
    moves_knight
    moves_through!
    register "N"

  end
end