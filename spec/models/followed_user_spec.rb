require 'rails_helper'

describe 'FollowedUser', type: :model do
  it 'twitter_idがないと無効' do
    followed_user = build(:followed_user, twitter_id:'')
    followed_user.valid?
    expect(followed_user.errors[:twitter_id]).to include('を入力してください')
  end
  it 'official_accountがないと無効' do
    followed_user = build(:followed_user, official_account:'')
    followed_user.valid?
    expect(followed_user.errors[:official_account]).to include('は一覧にありません')
  end
  it 'twitter_idが重複すると無効' do
    create(:followed_user, twitter_id:'87654')
    followed_user = build(:followed_user, twitter_id:'87654')
    followed_user.valid?
    expect(followed_user.errors[:twitter_id]).to include('はすでに存在します')
  end
end

