class Card < ApplicationRecord
  belongs_to :card_product
  belongs_to :user
end
