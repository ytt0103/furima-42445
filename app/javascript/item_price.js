// 関数名を priceCalc から priceCalculator に変更します
const priceCalculator = () => {
  // item-priceというIDを持つ要素（販売価格の入力欄）を取得
  const priceInput = document.getElementById("item-price");
  
  // 入力欄がある場合にのみ処理を実行
  if (priceInput) {
    priceInput.addEventListener("input", () => {
      // 入力された値を取得
      const inputValue = priceInput.value;
      
      // 販売手数料 (10%) を計算
      // Math.floorで小数点以下を切り捨て
      const addTaxDom = document.getElementById("add-tax-price");
      const tax = Math.floor(inputValue * 0.1);
      addTaxDom.innerHTML = tax.toLocaleString();
      
      // 販売利益を計算 (入力値 - 手数料)
      const profitDom = document.getElementById("profit");
      const profit = inputValue - tax;
      profitDom.innerHTML = profit.toLocaleString();
    });
  }
};

// ページが完全に読み込まれた後（turbo:load）に priceCalculator 関数を実行
window.addEventListener('turbo:load', priceCalculator);
window.addEventListener("turbo:render", priceCalculator);
//window.addEventListener('turbo:load', priceCalc);
//window.addEventListener('load', priceCalc); // turbo:loadに対応していないブラウザ向け