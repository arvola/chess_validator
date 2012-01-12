# Chess validator
#
# Author:: Mikael Arvola

require 'movement'

module Chess
  class Piece
    include Movement
    attr_accessor :color, :x, :y

    def initialize color
      @color = color
    end

    # Shortcut for class moves
    def moves
      self.class.moves
    end

    def moves_through?
      self.class.moves_through?
    end

    def self.register presentation
      Chess.registry[presentation] = self
    end

    def validate_move move
      valid = false
      moves.each do |v|
        res = v.valid? move
        return nil if res.nil?
        valid = true if res
      end
      valid
    end
  end

  def self.registry
    @registry = @registry ? @registry : {}
  end
end
