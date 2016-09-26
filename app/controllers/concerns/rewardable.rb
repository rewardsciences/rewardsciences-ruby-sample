module Rewardable
  def identify_reward_sciences_user(user)
    session[:reward_sciences_user_id] = reward_sciences.users.identify(user.email)['id']
  end

  def track_reward_sciences_activity(activity_slug)
    reward_sciences.activities.track(session[:reward_sciences_user_id], activity_slug)
  end

  def list_reward_sciences_rewards
    reward_sciences.rewards.list
  end

  def show_reward_sciences_reward(reward_id)
    reward_sciences.rewards.show(reward_id)
  end

  def redeem_reward_sciences_reward(reward_id)
    reward_sciences.rewards.redeem(session[:reward_sciences_user_id], reward_id)
  rescue RewardSciences::APIException => e
    redirect_to :back, alert: e.message.split(':').last
  end

  private

  def reward_sciences
    RewardSciences::RewardSciencesClient.new(
      Rails.application.secrets.reward_sciences_access_token,
      Rails.application.secrets.reward_sciences_environment
    )
  end
end
