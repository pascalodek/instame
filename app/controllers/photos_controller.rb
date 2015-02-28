class PhotosController < ApplicationController
  def index
  end

def new
      if session[:id]
          @title = "New Photo"
      else
          redirect_to(:controller => 'users', :action => 'login')
      end
  end
  
  def create
      new_photo = Photo.new(:user_id => params[:photo][:user_id], :date_time => Time.now, :file_name => params[:photo][:file_name].original_filename)
      name = new_photo.file_name
      directory = "app/assets/images/"
      path = File.join(directory, name)
      File.open(path, "wb") { |f| f.write(params[:photo][:file_name].read) }
      flash[:notice] = "Photo upload successful!"
      if new_photo.save
          redirect_to(:action => index, :id => session[:id])
      else
          redirect_to(:back, :flash => {:message => 'Error occurred, please try again!'})
      end
  end
end
