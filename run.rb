# Chess validator
#
# Author:: Mikael Arvola

$LOAD_PATH << './lib'

require 'board'
require 'moves'

if ARGV.length < 2
  puts "Two arguments required: board.txt and moves.txt"
  exit
end

board_file = ARGV[0]
moves_file = ARGV[1]

unless FileTest.exists?(board_file) && FileTest.exists?(moves_file)
  puts "File(s) not found, exiting."
  exit
end

# Auto-require all pieces
Dir.glob ("lib/pieces/*.rb") do |file|
  require File.absolute_path file
end

# Some shortcuts for controlling the objects
def move_is_valid? move, board
  move.valid? && (move.piece.moves_through? || board.path_empty?(move.x, move.y, move.x2, move.y2))
end

def move_is_safe? move, board
  # We are only concerned about the king
  if move.piece.class == Chess::King
    board.pieces.each do |piece|
      if piece.color != move.piece.color
        test_move = Moves::Move.new(piece.x, piece.y, move.x2, move.y2)
        test_move.piece = piece
        test_move.target = move.piece

        if move_is_valid? test_move, board
          #puts "King move is ILLEGAL"
          return false
        end
      end
    end
    #puts "King move is LEGAL"
  end
  true
end

board_text = File.open(board_file, 'rb') { |f| f.read }
moves_lines = File.open(moves_file, 'rb') { |f| f.readlines }

board = Chess::Board.from_text board_text

unless board
  puts "Could not parse board file."
  exit
end

require 'move_parser'

moves_lines.each do |v|
  move = Moves::Move.new(*(Moves.parse_line v))
  move.piece = board[move.x, move.y]
  move.target = board[move.x2, move.y2]

  if move_is_valid?(move, board) && move_is_safe?(move, board)
    puts "LEGAL"
  else
    puts "ILLEGAL"
  end
end

