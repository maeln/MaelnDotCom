# coding: utf-8
class AdminController < ApplicationController
	def index
		if session[:admin].nil?
			flash[:notice] = "Vous n'étes pas autorisez à faire cela."
			redirect_to :controller => "home", :action => "index"
		else
			@nouvelles = Nouvelle.order("created_at DESC")
		end
	end
	def show
		if session[:admin].nil?
			flash[:notice] = "Vous n'étes pas autorisez à faire cela."
			redirect_to :controller => "home", :action => "index"
		else
			@nouvelles = Nouvelle.find(params[:id])
			@comments = Comment.where(["nouvelle_id = ?", params[:id]]).order("created_at ASC")
		end
	end
	def remove_comment
		if session[:admin].nil?
			flash[:notice] = "Vous n'étes pas autorisez à faire cela."
			redirect_to :controller => "home", :action => "index"
		else
			@comment = Comment.find(params[:id])
			@comment.destroy
			flash[:notice] = "Commentaire détruit."
			redirect_to :action => "index"
		end
	end
	def connexion
		if cookies[:admin] != "0169d37410628f6364dc26b09a1ce38ed518eac5" #SHA1 : "admin_session"
			flash[:notice] = "Vous n'étes pas autorisez à faire cela."
			redirect_to :controller => "home", :action => "index"
		else
			if request.post?
				@admin = Admin.where(["login = ? and passwd = ?", params[:q][:login], Digest::SHA512.hexdigest(params[:q][:passwd])])
				if @admin.first.nil?
					flash[:notice] = "Impossible de ce connécter."
					redirect_to :controller => "home", :action => "index"
				else
					session[:admin] = @admin.first
					flash[:notice] = "Vous étes connécté #{params[:q][:login]} !"
					redirect_to :action => "index"
				end
			end
		end
	end
	def create
		if session[:admin].nil?
			flash[:notice] = "Vous n'étes pas autorisez à faire cela."
			redirect_to :controller => "home", :action => "index"
		else
			if request.post?
				@nouvelles = Nouvelle.new(params[:post])
				@nouvelles.save
				flash[:notice] = "La nouvelle a bien été crée."
				redirect_to :action => "index"
			end
		end
	end
	def edit
		if session[:admin].nil?
			flash[:notice] = "Vous n'étes pas autorisez à faire cela."
			redirect_to :controller => "home", :action => "index"
		else
			@nouvelles = Nouvelle.find(params[:id])
			if request.post?
				@nouvelles.update_attributes(params[:post])
				flash[:notice] = "La nouvelles a bien été édité."
				redirect_to :action => "index"
			end
		end
	end
	def destroy
		if session[:admin].nil?
			flash[:notice] = "Vous n'étes pas autorisez à faire cela."
			redirect_to :controller => "home", :action => "index"
		else
			unless request.post?
				nb1, nb2 = rand(3), rand(3)
				flash[:nb1] = nb1
				flash[:nb2] = nb2
				session[:rep] = nb1 + nb2
			end
			if request.post?
				if params[:q][:reponse] == session[:rep].to_s
					@nouvelles = Nouvelle.find(params[:id])
					@nouvelles.destroy
					flash[:notice] = "La nouvelle a bien été supprimé."
					redirect_to :action => "index"
				else
					flash[:notice] = "Mauvaise réponse."
					redirect_to :controller => "home", :action => "index"
				end
			end
		end
	end
	def adduser_talk
		if session[:admin].nil?
			flash[:notice] = "Vous n'étes pas autorisez à faire cela."
			redirect_to :controller => "home", :action => "index"
		else
			if request.post? then
				@user = params[:post]
				@user["passwd"] = Digest::SHA512.hexdigest(@user["passwd"])
				@user = User.new(@user)
				@user.save
				flash[:notice] = "Utilisateur crée."
				redirect_to :action => "index"
			end
		end
	end
end
