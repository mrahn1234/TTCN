class Book < ApplicationRecord

	belongs_to :author
	#ManytoMany Book_Category
	has_many :bookcategories, dependent: :destroy
	has_many :categories, through: :bookcategories	#, source: :category
	accepts_nested_attributes_for :bookcategories, allow_destroy: true
	rails_admin do
		configure :categories do
			# configuration here
		end
	end
	has_many :requests, dependent: :destroy
	
	#Validate
	validates :name, presence: true, length: { maximum: 50 }
	validates :quantity, presence: true, length: { maximum: 1000 }
	# validates :author_id, presence: true
	has_attached_file :book_img, styles: { book_index: "250x350>", book_show: "325x475>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :book_img, content_type: /\Aimage\/.*\z/

	#  	def self.to_csv(option ={})
	# 	CSV.generate(option) do |csv|
	# 		csv << column_names
	# 		all.each do |book|
	# 			csv << book.attributes.values_at(*column_names)
	# 		end
	# 	end
	# end
end
