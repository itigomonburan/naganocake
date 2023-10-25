class Item < ApplicationRecord

  has_one_attached :image


  def get_image(size)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize: size).processed
  end

  def with_tax_price
    (price * 1.1).floor
  end

# 税込み
  def add_tax_price
    (self.price * 1.10).round
  end

  #検索機能
  def self.search_for(content)
    Item.where('name LIKE ?','%'+content+'%')
  end

  belongs_to :order,optional: true
  belongs_to :genre,optional: true
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details # 中間テーブルを経由してitemsと関連付ける

  validates :image, presence:true
  validates :name, presence:true, uniqueness: true
  validates :description, presence:true
  validates :price, presence:true, numericality: {only_integer: true, greater_than_or_equal_to: 1}

end
