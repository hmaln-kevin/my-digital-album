class Figure < ApplicationRecord
    has_many :packs
    has_many :users, through: :packs
end
