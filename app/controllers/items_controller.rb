class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] 
  before_action :set_item, only: [:show, :edit, :update]
  before_action :contributor_confirmation, only: [:edit, :update]

  def index
    @items = Item.all.order("created_at DESC")
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

  def show
    #@item = Item.find(params[:id])
  end

  def edit
    #@item = Item.find(params[:id]) # 👈 set_itemメソッドに移行
  end

  # 🚨【新機能】編集内容を更新するアクション
  def update
    # @item = Item.find(params[:id]) # 👈 set_itemメソッドに移行
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # 🚨【新機能】商品を削除するアクション
  #def destroy
    # @item = Item.find(params[:id]) # 👈 set_itemメソッドに移行
    #@item.destroy
    #redirect_to root_path
  #end

  private

   # 🚨【新機能】商品データを取得する共通メソッド
  def set_item
    @item = Item.find(params[:id])
  end

  # 🚨【新機能】出品者かどうかを確認するメソッド
  def contributor_confirmation
    # 現在ログインしているユーザーと、商品の出品者が一致しない場合、トップページにリダイレクト
    unless current_user == @item.user
      redirect_to root_path
    end
  end

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