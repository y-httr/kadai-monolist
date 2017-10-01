class OwnershipsController < ApplicationController
  #wantボタンが押されたらクリエイト
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
    end
    
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @item = Item.find(params[:item_id])
    if params[:type] == "Want"
      current_user.unwant(@item)
      flash[:success]="商品の Want を解除しました"
    end
    redirect_back(fallback_location: root_path)
  end
end
