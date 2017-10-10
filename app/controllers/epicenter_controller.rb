class EpicenterController < ApplicationController

  before_action :authenticate_user!

  def tag_tweets
    @tag = Tag.find(params[:id])
  end

  def feed
    @following_tweets = []

    Tweet.all.order(created_at: :desc).each do |tweet|
      if current_user.following.include?(tweet.user_id) || current_user.id == tweet.user_id
        @following_tweets.push(tweet)
      end
    end
  end

  def all_users
    @users = User.all
  end

  def show_user
    @user = User.find(params[:id])
  end

  def following
    @user = User.find(params[:id])
    @users = []

    User.all.each do |user|
      if @user.following.include?('id' => user.id.to_s)
        @users.push(user)
      end
    end
  end

  def followers
    @user = User.find(params[:id])
    @users = []

    User.all.each do |user|
      if user.following.include?('id' => @user.id.to_s)
        @users.push(user)
      end
    end
  end

  def now_following
    current_user.following.push(id: params[:id])
    current_user.save

    redirect_to show_user_path(id: params[:id])
  end

  def unfollow
    current_user.following.delete('id' => params[:id])
    current_user.save

    redirect_to show_user_path(id: params[:id])
  end
end
