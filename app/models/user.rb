class User < ActiveRecord::Base
  has_many :games

  def score
    score = 0
    Game.won.where(:user_id => self.id).each do |game|
      score += game.answer.to_i
    end
    return score || 0
  end

  def self.high_scores(num)
    winners = []
    users = User.all.sort_by{|user| user.score}.reverse.first(num)
    users.each do |user|
      winners << {
        "username" => user.username,
        "score" => user.score
      }
    end
    return winners
  end
end