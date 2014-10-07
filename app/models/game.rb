class Game < ActiveRecord::Base
  belongs_to :user
  has_many :attempts

  scope :won, -> { where(:result => "win") }
end