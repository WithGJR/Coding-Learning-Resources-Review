class PagesController < ApplicationController
  def index
  end

  def share
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def manage
    @posts = current_user.posts 

    respond_to do |format|
      format.html { render :layout => false }
    end
  end
end
