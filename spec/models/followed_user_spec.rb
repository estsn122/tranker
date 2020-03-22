require 'rails_helper'

describe 'FollowedUser', type: :model do
  it 'twitter_idがないと無効' do
    user = build(:followed_user, twitter_id:'')
    user.valid?
    expect(user.errors[:twitter_id]).to include('を入力してください')
  end
  it 'truncationがないと無効' do
    user = build(:followed_user, truncation:'')
    user.valid?
    expect(user.errors[:truncation]).to include('は一覧にありません')
  end
end

