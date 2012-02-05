# coding: utf-8
class HomeController < ApplicationController
	def index
		@nouvelles = Nouvelle.order("created_at DESC").limit(5)
	end
	def show
		@nouvelles = Nouvelle.find(params[:id])
		@comments = Comment.where(["nouvelle_id = ?", params[:id]]).order("created_at ASC")
	end
	def comment
		if request.post?
			@rq = params[:q]
			@rq['nouvelle_id'] = params[:id]
			@comment = Comment.new(@rq)
			@comment.save
			flash[:notice] = "Commentaire ajouté."
			redirect_to :action => "index"
		end
	end
	def search
		@nouvelles = Nouvelle.all
		@tags = Array.new
		@tags = params[:q].split(' ')
		@result = Array.new
		@tags.each do |i|
			@nouvelles.each do |n|
				if n.tags.include?(i) then
				@result << n
				end
			end
		end
	end
end
