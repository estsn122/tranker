require 'rails_helper'

RSpec.describe 'ImportedUsers', type: :system do
  xdescribe 'ユーザーIDの取得機能' do
    let(:imported_user) { ImportedUser.import_users }
    it 'ツイートが取得できる' do
      expect(imported_user.first.to_s).to include '#<Twitter::Tweet:'
    end
    it '取得するツイート数が正しい' do
      expect(imported_user.length).to eq Settings.get_user_param.num
    end
  end
end

