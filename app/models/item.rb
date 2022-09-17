class Item < ApplicationRecord

  has_one_attached  :image
  belongs_to        :genre
  has_many          :carts,        dependent: :destroy
  has_many          :order_items,  dependent: :destroy

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  #消費税のメソッド
  def with_tax_price
    (price * 1.1).floor
  end

end
