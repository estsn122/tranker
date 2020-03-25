require 'rails_helper'

describe 'PointRecord', type: :model do
  it 'twitter_idがないと無効' do
    point_log = build(:point_record, twitter_id: '')
    point_log.valid?
    expect(point_log.errors[:twitter_id]).to include('を入力してください')
  end
  it 'pointsがないと無効' do
    point_log = build(:point_record, points: '')
    point_log.valid?
    expect(point_log.errors[:points]).to include('を入力してください')
  end
  it 'recorded_onがないと無効' do
    point_log = build(:point_record, recorded_on: '')
    point_log.valid?
    expect(point_log.errors[:recorded_on]).to include('を入力してください')
  end
  it 'twitter_idは重複しても有効(recorded_onは異なる)' do
    create(:point_record, twitter_id: '654321', recorded_on: Date.yesterday)
    point_log = build(:point_record, twitter_id: '654321', recorded_on: Date.today)
    expect(point_log.valid?).to be true
  end
  it 'recorded_onは重複しても有効(twitter_idは異なる)' do
    create(:point_record, twitter_id: '54321',recorded_on: Date.today)
    point_log = build(:point_record, twitter_id: '51234', recorded_on: Date.today)
    expect(point_log.valid?).to be true
  end
  it 'twitter_idとrecorded_onの組み合わせは重複すると無効' do
    create(:point_record, twitter_id: '76543', recorded_on: Date.today)
    point_log = build(:point_record, twitter_id: '76543', recorded_on: Date.today)
    point_log.valid?
    expect(point_log.errors[:twitter_id]).to include('はすでに存在します')
  end
end
