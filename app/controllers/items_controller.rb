class ItemsController < ApplicationController
  def new
    #空の配列として初期化(itemsに値が入るのは検索ワードが入力された時だけ)
    #検索ワードが入ってない時でもviewから呼ばれるので初期化しないとエラーになる
    @items = []
    #text_field_tag :keywordから，受け取る
    @keyword = params[:keyword]
    if @keyword
      results = RakutenWebService::Ichiba::Item.search({
        keyword: @keyword,
        imageFlag: 1,
        hits: 20,
      })
      results.each do |result|
        #扱いやすいようにItemとしてインスタンスを作成する（保存はしない）
        item = Item.find_or_initialize_by(read(result))
        #配列に要素を追加
        @items << item
      end
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @want_users = @item.want_users
    @have_users = @item.have_users
  end
  
end
