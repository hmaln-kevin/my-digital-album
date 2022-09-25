class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :packs
  has_many :figures, through: :packs

  # Check if user have pack to be opened, otherwise return false
  def enough_pack
    self.unopened != 0 ? true : false
  end

  # Outdated
  # def self.validate_pack (user)
  #   return user.unopened != 0 ? true : false
  # end

  # If last_sign_it was yesterday and current_sign_in is today return true 
  def free_pack
    if self.last_sign_in_at.day != Date.today.day
      self.unopened += 1
      self.last_sign_in_at = self.current_sign_in_at
      self.save
      return true
    else
      return false
    end
  end

  def can_open
    Pack.opening_count(self) < PACK_PER_DAY ? true : false
  end

end
