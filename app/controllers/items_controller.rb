class ItemsController < ApplicationController
  # ログイン状態のチェック (New!)
  before_action :authenticate_user!, only: [:new, :create] 

  def index
    @items = Item.all 
  end

  def new # このアクションを追加
    @item = Item.new # 空のItemオブジェクト（インスタンス）を作成
  end
end