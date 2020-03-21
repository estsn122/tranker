require 'rails_helper'

describe 'Ranker', type: :model do
  it 'twitter_idがないと無効' do
    ranker = build(:ranker, twitter_id:'')
    ranker.valid?
    expect(ranker.errors[:twitter_id]).to include('を入力してください')
  end
  it 'pointsがないと無効' do
    ranker = build(:ranker, points:'')
    ranker.valid?
    expect(ranker.errors[:points]).to include('を入力してください')
  end
  it 'officialがないと無効' do
    ranker = build(:ranker, official:'')
    ranker.valid?
    expect(ranker.errors[:official]).to include('は一覧にありません')
  end
  it 'twitter_idが重複すると無効' do
    create(:ranker, twitter_id:'87654')
    ranker = build(:ranker, twitter_id:'87654')
    ranker.valid?
    expect(ranker.errors[:twitter_id]).to include('はすでに存在します')
  end
end

