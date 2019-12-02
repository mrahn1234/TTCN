class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	  after_create :create_cart
	  devise :database_authenticatable, :registerable,
	  :recoverable, :rememberable, :validatable
	#   has_secure_password
  	# devise :database_authenticatable, :registerable,:rememberable
    #     #   validates_uniqueness_of :email, case_sensitive: false

  	#ManytoMany User_Like_Book
	# has_many :likes, dependent: :destroy
	# has_many :liked_books, through: :likes, source: :book	
	# #ManytoMany User_Review_Book
	# has_many :reviews, dependent: :destroy
	# has_many :reviewed_books, through: :reviews, source: :book
	# #OneToMany Request pending shopee..
	has_many :carts, dependent: :destroy
	# has_many :books, through: :cart




	def create_cart
		if self.save
			return self.carts.create(verify: 3)
		end
	end
end
