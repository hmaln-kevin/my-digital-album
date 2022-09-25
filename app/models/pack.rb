class Pack < ApplicationRecord
  belongs_to :figure
  belongs_to :user
  # CLASS METHOD
  # User last opened pack
  # See if is not possible to change to user.rb
  def self.last_opening(user)
    user.packs.last.created_at
  end

  def self.opening_count(user)
    user.packs.where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).count/(CARD_PER_PACK)
  end

end

