class OrdersController < ApplicationController
  # ログインしていないユーザーはログインページに飛ばす
  before_action :authenticate_user!
  # 購入する商品を特定する
  before_action :set_item, only: [:index, :create]
  # 出品者自身や売却済み商品のページにアクセスしようとしたらトップに戻す
  before_action :redirect_if_invalid, only: [:index, :create]

  # 購入ページ（フォーム表示）
  def index
    # gonを使って、JavaScript側に公開鍵を渡す
    gon.payjp_public_key = ENV["PAYJP_PUBLIC_KEY"]
    # フォーム用の空のOrderAddressオブジェクトを生成
    @order_address = OrderAddress.new(item_id: @item.id, user_id: current_user.id)
  end

  # 購入処理
  def create
    # フォームから送られてきた情報でOrderAddressオブジェクトを生成
    @order_address = OrderAddress.new(order_params)

    # バリデーションを実行（Formオブジェクトで定義したもの）
    if @order_address.valid?
      # バリデーションOKなら、決済処理を実行
      pay_item
      # データベースに保存（OrderとAddressテーブル）
      @order_address.save
      # トップページにリダイレクト
      redirect_to root_path
    else
      # バリデーションNGなら、購入ページを再表示
      # JavaScriptに再度、公開鍵を渡す必要がある
      gon.payjp_public_key = ENV["PAYJP_PUBLIC_KEY"]
      # render :index だとHTTPステータスが200 (OK) になってしまうため、
      # :unprocessable_entity (422) を指定して、バリデーションエラーであることを明示する
      render :index, status: :unprocessable_entity
    end
  end

  private

  # フォームから送られてくるパラメーターを安全に受け取る（ストロングパラメーター）
  def order_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :block, :building, :phone_number
    ).merge(
      user_id: current_user.id, # ログイン中のユーザーID
      item_id: params[:item_id], # 購入対象の商品ID（URLから取得）
      token: params[:order_address][:token] # JavaScriptから送られてきたトークン
    )
  end

  # 決済処理を実行するメソッド
  def pay_item
    # 秘密鍵を設定
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    # Payjp::Charge.create で決済を実行
    Payjp::Charge.create(
      amount: @item.price,        # 商品の金額
      card: order_params[:token], # フォームから送られてきたカードトークン
      currency: 'jpy'             # 通貨単位（日本円）
    )
  end

  # 購入対象の商品をデータベースから見つける
  def set_item
    @item = Item.find(params[:item_id])
  end

  # 不正なアクセス（出品者が自分自身ののを買おうとしたり、売切れ品を買おうとした）を制御
  def redirect_if_invalid
    # 出品者＝現在のユーザー または 商品がすでに売れている 場合
    if @item.user_id == current_user.id || @item.order.present?
      # トップページに強制的に戻す
      redirect_to root_path
    end
  end
  
end