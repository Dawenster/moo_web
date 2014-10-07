class Game < ActiveRecord::Base
  belongs_to :user
  has_many :attempts

  scope :won, -> { where(:result => "win") }

  def self.fastest_by_digit(num)
    fastest = []
    count = 0
    (1..7).each do |digit|
      games = Game.won.where(:digits => digit)
      games = games.sort_by{|game| game.time}.reverse.first(num)
      if games.any?
        fastest << {
          "digit" => digit,
          "array" => []
        }
        games.map do |game|
          if game.user
            fastest[count]["array"] << {
              "username" => game.user.username,
              "answer" => game.answer,
              "time" => game.time
            }
          end
        end
        count += 1
      end
    end
    return fastest
  end
end