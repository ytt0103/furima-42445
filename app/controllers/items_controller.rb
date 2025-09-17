class ItemsController < ApplicationController
  def index
    @items = Item.all # この行を追加
  end
end