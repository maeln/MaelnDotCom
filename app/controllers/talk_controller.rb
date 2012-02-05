# coding: utf-8
class TalkController < ApplicationController
	def index
		if session[:user].nil? then
			redirect_to :action => "connexion"
		else
			if request.post? then
				@post = params[:post]
				@post['pseudo'] = session[:user].login
				@post = Talking.new(@post)
				@post.save
				flash[:notice] = "Message envoyé."
				redirect_to :action => "index"
			end
			@msg = Talking.order("created_at DESC")
		end
	end
	def connexion
		if request.post?
			@user = User.where(["login = ? and passwd = ?", params[:q][:login], Digest::SHA512.hexdigest(params[:q][:passwd])])
			if @user.first.nil?
				flash[:notice] = "Mauvais mot de passe / login"
			else
				session[:user] = @user.first
				flash[:notice] = "Welcome #{session[:user].login}"
				redirect_to :action => "index"
			end
		end
	end
end
