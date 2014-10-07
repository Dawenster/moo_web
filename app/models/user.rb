class User < ActiveRecord::Base
  has_many :games

  def score
    score = 0
    Game.won.where(:user_id => self.id).each do |game|
      score += game.answer.to_i
    end
    return score || 0
  end
end