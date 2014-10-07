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
    winners = {}
    Game.won.each do |game|
      user_info_array = [game.user_id, game.user.username]
      winners[user_info_array] ||= 0
      winners[user_info_array] += game.answer.to_i
    end
    limit = num - 1
    return Hash[winners.sort_by { |k,v| -v }[0..limit]]
  end
end