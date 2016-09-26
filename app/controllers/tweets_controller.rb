class TweetsController < ApplicationController
  before_filter :authorize

  def index
    @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)

    if @tweet.save
      track_reward_sciences_activity('tweeted')
      redirect_to(tweets_path, notice: 'Tweet successfully created.')
    else
      render :new
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
