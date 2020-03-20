require 'rails_helper'

RSpec.describe 'ImportedUsers', type: :system do
  it 'メイン画面が表示されること' do
    visit root_path
    expect(page).to have_content('駆け出しエンジニア')
  end
end

