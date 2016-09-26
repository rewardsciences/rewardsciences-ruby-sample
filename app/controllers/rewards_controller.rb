class RewardsController < ApplicationController
  before_filter :authorize

  def index
    @rewards = list_reward_sciences_rewards['data']
  end

  def show
    @reward = show_reward_sciences_reward(params[:id])
  end

  def redeem
    redeem_reward_sciences_reward(params[:id])
  end
end
