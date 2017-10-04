class Want < Ownership
  def self.ranking
    #groupはSQLのgroup byに相当
    #.countは{:item_id => count}のハッシュで取得
    self.group(:item_id).order("count_item_id DESC").limit(10).count(:item_id)
  end
end
