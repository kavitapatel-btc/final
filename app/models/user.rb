class User < ApplicationRecord
  validates :name, presence:true, uniqueness: true
  has_secure_password
  validates :password, :presence =>true, :confirmation => true, :length =>{:within =>2..40}
  after_destroy :ensure_an_admin_remains
  has_many :orders

  private
    def ensure_an_admin_remains
      if User.count.zero?
        raise "Can't delete last user"
      end
    end
end
