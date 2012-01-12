module Moves
  def self.parse_line line
    v = /([a-h])([1-8]) ([a-h])([1-8])/.match line.downcase

    return nil unless v

    [v[1].ord - 97, v[2].to_i - 1, v[3].ord - 97, v[4].to_i - 1]
  end
end