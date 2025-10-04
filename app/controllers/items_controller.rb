class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create] 

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params) # 1. フォームのデータを受け取り、新しいItemオブジェクトを作る
    if @item.save # 2. データベースに保存を試みる
      redirect_to root_path # 3. 保存が成功したらトップページへ移動
    else
      render :new, status: :unprocessable_entity # 4. 保存が失敗したら、エラーメッセージ付きで出品ページを再表示
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :image, 
      :name, 
      :description, 
      :category_id, 
      :item_status_id, 
      :shipping_fee_payer_id, 
      :prefecture_id, 
      :delivery_day_id, 
      :price
    ).merge(user_id: current_user.id) # 5. ログインしているユーザーのIDを商品データに加える
  end
end