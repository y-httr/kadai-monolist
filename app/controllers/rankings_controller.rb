class RankingsController < ApplicationController
  def want
    @ranking_counts = Want.ranking
    #.keysはハッシュで使えるメソッド？
    @items = Item.find(@ranking_counts.keys)
  end
end
