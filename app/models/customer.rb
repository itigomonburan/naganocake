class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :adresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :phone_number, presence: true
  validates :address, presence: true
  validates :post_code, presence: true

  #顧客フルネーム
  def full_name
    self.last_name + " " + self.first_name
  end

  #会員ステータス
  def customer_status
    if is_active == false
      "退会"
    else
      "有効"
    end
  end

  def active_for_authentication?
    super && (is_active == true)
  end
end
