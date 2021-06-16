class Batch::DataReset
  def self.data_reset
    Contact.delete_all
    p "お問い合わせのデータは全て削除しました"
  end
end