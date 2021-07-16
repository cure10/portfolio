require 'rails_helper'

RSpec.describe Post, type: :model do
  it "タイトルと本文と写真があれば投稿できる" do
    expect(FactoryBot.create(:post)).to be_valid
  end
end
