require 'rails_helper'

describe 'ImportedUser', type: :model do
  it 'twitter_idがないと無効' do
    imported_user = build(:imported_user, twitter_id:'')
    imported_user.valid?
    expect(imported_user.errors[:twitter_id]).to include('を入力してください')
  end
  it 'twitter_idが重複すると無効' do
    create(:imported_user, twitter_id:'12345')
    imported_user = build(:imported_user, twitter_id:'12345')
    imported_user.valid?
    expect(imported_user.errors[:twitter_id]).to include('はすでに存在します')
  end
  it 'aggregate_following_users_onはデフォルトでnil' do
    imported_user  = create(:imported_user)
    expect(imported_user.aggregate_following_users_on).to be_nil
  end
end
