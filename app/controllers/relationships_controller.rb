class RelationshipsController < ApplicationController
  def create
    session[:previous_url] = request.referer
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to session[:previous_url]
    session.delete(:previous_url)

  end

  def destroy
    session[:previous_url] = request.referer
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to session[:previous_url]
    session.delete(:previous_url)
  end
end