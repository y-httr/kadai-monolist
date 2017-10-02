class OwnershipsController < ApplicationController
  #want/haveボタンが押されたらクリエイト
  def create
    #find_or_initialize_byは見つからなければnewするメソッド(saveはしない)
    @item = Item.find_or_initialize_by(code: params[:item_code])
    
    unless @item.persisted?
      #.persisted?はすでに保存されているかどうか判定する
      #保存されていない場合，先に@itemを保存する
      results = RakutenWebService::Ichiba::Item.search(itemCode: @item.code)
      
      @item = Item.new(read(results.first))
      @item.save
    end
    
    #Want関係として保存
    if params[:type] =="Want"
      current_user.want(@item)
      flash[:success]="商品を Want しました"
    #have関係として保存
    elsif params[:type] == "Have"
      current_user.have(@item)
      flash[:success] = "商品を Have しました"
    end
    
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @item = Item.find(params[:item_id])
    if params[:type] == "Want"
      current_user.unwant(@item)
      flash[:success]="商品の Want を解除しました"
    elsif params[:type] == "Have"
      current_user.unhave(@item)
      flash[:success]="商品の Have を解除しました"
    end
    redirect_back(fallback_location: root_path)
  end
end
