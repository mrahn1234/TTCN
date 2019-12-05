class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
        after_create :create_cart
        devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
      #   has_secure_password
        # devise :database_authenticatable, :registerable,:rememberable
      #     #   validates_uniqueness_of :email, case_sensitive: false
  

      has_many :carts, dependent: :destroy
  
  
  
  
      def create_cart
          if self.save
              return self.carts.create(verify: 3)
          end
      end
  end