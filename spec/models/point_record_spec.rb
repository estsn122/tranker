require 'rails_helper'

describe 'PointRecord', type: :model do
  it 'twitter_idがないと無効' do
    point_record = build(:point_record, twitter_id: '')
    point_record.valid?
    expect(point_record.errors[:twitter_id]).to include('を入力してください')
  end
  it 'pointsがないと無効' do
    point_record = build(:point_record, points: '')
    point_record.valid?
    expect(point_record.errors[:points]).to include('を入力してください')
  end
  it 'recorded_onがないと無効' do
    point_record = build(:point_record, recorded_on: '')
    point_record.valid?
    expect(point_record.errors[:recorded_on]).to include('を入力してください')
  end
  it 'twitter_idは重複しても有効(recorded_onは異なる)' do
    create(:point_record, twitter_id: '654321', recorded_on: Date.yesterday)
    point_record = build(:point_record, twitter_id: '654321', recorded_on: Date.today)
    expect(point_record).to be_valid
  end
  it 'recorded_onは重複しても有効(twitter_idは異なる)' do
    create(:point_record, twitter_id: '54321',recorded_on: Date.today)
    point_record = build(:point_record, twitter_id: '51234', recorded_on: Date.today)
    expect(point_record).to be_valid
  end
  it 'twitter_idとrecorded_onの組み合わせは重複すると無効' do
    create(:point_record, twitter_id: '76543', recorded_on: Date.today)
    point_record = build(:point_record, twitter_id: '76543', recorded_on: Date.today)
    point_record.valid?
    expect(point_record.errors[:twitter_id]).to include('はすでに存在します')
  end
end
