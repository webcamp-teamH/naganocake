class Address < ApplicationRecord

  belongs_to :customer

  def address_display
    '〒' + postcode + '' + address + '' + name
  end
end
