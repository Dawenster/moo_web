class Game < ActiveRecord::Base
  belongs_to :user
  has_many :attempts

  scope :won, -> { where(:result => "win") }

  def self.fastest_by_digit(num)
    fastest = {}
    (1..7).each do |digit|
      games = Game.won.where(:digits => digit)
      games = games.sort_by{|game| game.time}.reverse.first(num)
      games = games.map do |game|
        [game.user.username, game.answer, game.time] if game.user
      end
      fastest[digit] = games
    end
    return fastest
  end
end