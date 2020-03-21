require 'rails_helper'

describe 'ImportedUser', type: :model do
  it 'twitter_idがないと無効' do
    user = build(:imported_user, twitter_id:'')
    user.valid?
    expect(user.errors[:twitter_id]).to include('を入力してください')
  end
  it 'twitter_idが被ってると無効' do
    create(:imported_user, twitter_id:'12345')
    user = build(:imported_user, twitter_id:'12345')
    user.valid?
    expect(user.errors[:twitter_id]).to include('はすでに存在します')
  end
  it 'registered_onはデフォルトでnil' do
    user = create(:imported_user)
    expect(user.registered_on).to eq nil
  end
end
