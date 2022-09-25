class Figure < ApplicationRecord
    has_many :packs
    has_many :users, through: :packs

    # Class method to select random figures from collection and put on the current_user.figures
    def self.pack_open(user)
        p = Array.new
        for a in 1..CARD_PER_PACK
            new_figure = Figure.all.shuffle.first
            user.figures << new_figure
            p << new_figure.name
        end
        user.unopened -= 1 # This seems a little bit strange but I will keep it here.
        user.save
        return p
    end
end
