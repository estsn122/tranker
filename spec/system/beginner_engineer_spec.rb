require 'rails_helper'

RSpec.describe 'BeginnerEngineers', type: :system do
  it 'テスト' do
    expect(Rails.application.credentials.num).to eq 14
  end
end
