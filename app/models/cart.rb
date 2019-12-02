class Cart < ApplicationRecord
	
	belongs_to :user

	# attr_accessor :current_user

	has_many :requests, dependent: :destroy
		
	# has_many :books, through: :request, source: :book

	scope :carts_admin, -> {where "verify not like '3'"} 

	# scope :carts_user, -> {where user_id: current_user.id, verify: !3}

	rails_admin do
		# configure :requests do
		  
		# end
		# configure :books do
		  
		# end
	end
	

end
