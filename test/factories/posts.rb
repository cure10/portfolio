FactoryBot.define do
  factory :post do
    title { "テスト投稿"}
    title_comment { "テストの投稿です" }
    title_image_id { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/sketch.jpg')) }
  end
end
