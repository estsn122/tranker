require 'rails_helper'

describe 'PointLog', type: :model do
  it 'twitter_idがないと無効' do
    point_log = build(:point_log, twitter_id: '')
    point_log.valid?
    expect(point_log.errors[:twitter_id]).to include('を入力してください')
  end
  it 'pointsがないと無効' do
    point_log = build(:point_log, points: '')
    point_log.valid?
    expect(point_log.errors[:points]).to include('を入力してください')
  end
  it 'aggregated_onがないと無効' do
    point_log = build(:point_log, aggregated_on: '')
    point_log.valid?
    expect(point_log.errors[:aggregated_on]).to include('を入力してください')
  end
  it 'twitter_idは重複しても有効(aggregated_onは異なる)' do
    create(:point_log, twitter_id: '654321', aggregated_on: Date.yesterday)
    point_log = build(:point_log, twitter_id: '654321', aggregated_on: Date.today)
    expect(point_log.valid?).to be true
  end
  it 'aggregated_onは重複しても有効(twitter_idは異なる)' do
    create(:point_log, twitter_id: '54321',aggregated_on: Date.today)
    point_log = build(:point_log, twitter_id: '51234', aggregated_on: Date.today)
    expect(point_log.valid?).to be true
  end
  it 'twitter_idとaggregated_onの組み合わせは重複すると無効' do
    create(:point_log, twitter_id: '76543', aggregated_on: Date.today)
    point_log = build(:point_log, twitter_id: '76543', aggregated_on: Date.today)
    point_log.valid?
    expect(point_log.errors[:twitter_id]).to include('はすでに存在します')
  end
end
