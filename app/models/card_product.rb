class CardProduct < ApplicationRecord

  def self.parse_card_product(card_product_object)
    @card_product = CardProduct.create(
      token: card_product_object['token'], 
      name: card_product_object['name']
    )

    @card_product
  end
  
end
