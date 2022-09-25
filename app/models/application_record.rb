class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # Define the number of cards per pack, used on Figures, Pack and User models
  CARD_PER_PACK = 4
  PACK_PER_DAY = 5
end
