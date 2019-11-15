class AuthorsController < ApplicationController

	before_action :find_author, only: [:show, :edit, :update, :destroy]
	def index
		#@authors = Author.paginate(page: params[:page])
		@q = Author.search(params[:q])
  		@search = @q.result(distinct: true)
		@pagy, @authors = pagy_countless(@search.order("created_at DESC"), items: 9)
    	#@full_authors = @q.result
    	# byebug
    	# respond_to do |format|
	    #   format.html
	    #   format.xls{send_data @authors.to_csv(col_sep: "\t")}
    	# end
	end

	def show
		@books = @author.books
		@authors = Author.all
	end

	def new
		@author = Author.new
	end

	def create
		@author = Author.new(author_params)
		
		if @author.save
			flash[:notice] = 'Author added!'   
			redirect_to @author
		else 
			render "new"
		end
	end

	def edit
		@author = Author.find(params[:id])   
	end

	def update
		if @author.update_attributes author_params
			flash[:success] = "Author updated!"
			redirect_to @author
		else
			render "edit"
		end
	end

	# def destroy
	# 	@author.destroy
	# 	respond_to do |format|
	#       format.html { redirect_to posts_url, notice: 'Author was successfully destroyed.' }
	#       format.json { head :no_content }
	#       format.js 
    # 	end
	# end
	def destroy   
		@author = Author.find(params[:id])   
		@author.books.delete(@author.books)
		if @author.delete
		  flash[:notice] = 'Product deleted!'   
		  redirect_to authors_path   
		else   
		  flash[:error] = 'Failed to delete this product!'   
		  render :destroy   
		end   
	  end   

	  def convert arr
		newArr = []
		arr.each do |object|
	  		newMyObject = Author.new(object)
	  		newArr<<newMyObject
		end
		return newArr
	end

	private

		def author_params
			params.require(:author).permit(:name, :email, :info)
		end

		def find_author
			@author = Author.find(params[:id])
			return if @author
			flash[:danger] = "error"
    		redirect_to authors_path
		end
		
end
