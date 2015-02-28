class CommentsController < ApplicationController
  def new
  	if session[:id]
          @title = "Add new Comment"
          @photo = Photo.find_by_id(params[:id])
      else
          redirect_to(:controller => 'users', :action => 'login')
      end
  end

  def create
      comment = Comment.new(:comment => params[:comment][:comment], :photo_id => params[:id], :user_id => params[:comment][:user_id],:date_time => Time.now)
      if comment.save
          redirect_to(:controller => 'photos', :action => 'index', :id => params[:comment][:photo_id])
      else
          redirect_to(:back, :flash => {:message => 'Enter comment'})
      end
      
  end
end
