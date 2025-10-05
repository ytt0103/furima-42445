const imagePreview = () => {
  // 1. input要素（ファイル選択欄）を取得。HTML側でIDを設定済みのはず
  const fileInput = document.getElementById('item-image');
  
  // input要素がない場合は処理を終了
  if (!fileInput) return;

  // 2. ファイルが選択された時（changeイベント）に処理を実行
  fileInput.addEventListener('change', (e) => {
    // 選択されたファイル（Fileオブジェクト）を取得
    const file = e.target.files[0];
    
    // Fileオブジェクトを読み込むためのFileReaderオブジェクトを作成（ファイルを読み込むための道具）
    const reader = new FileReader();
    
    // 3. ファイルの読み込みが完了した時の処理を設定
    reader.onload = () => {
      // 4. プレビューを表示する場所（親要素）を取得
      const previewWrapper = document.querySelector('.click-upload');
      
      // 5. 既にプレビュー画像があれば削除する（新しい画像に切り替えるため）
      const existingPreview = document.getElementById('preview-image');
      if (existingPreview) {
        existingPreview.remove();
      }
      
      // 6. プレビュー用のHTML要素（<img>タグ）を作成
      const previewImage = document.createElement('img');
      previewImage.setAttribute('src', reader.result); // 読み込んだ画像データを設定
      previewImage.setAttribute('id', 'preview-image'); // JSで識別するためのID
      previewImage.classList.add('preview-img'); // CSSを当てるためのクラス

      // 7. 親要素（.click-upload）の最後に<img>タグを追加して表示
      previewWrapper.appendChild(previewImage);
    };
    
    // 8. ファイルをデータURLとして読み込み開始（これが完了するとreader.onloadが実行される）
    reader.readAsDataURL(file);
  });
};

// ページが完全に読み込まれた時、またはTurbo（Rails 7.1の仕組み）でページが遷移した時に実行
window.addEventListener('turbo:load', imagePreview);
window.addEventListener('load', imagePreview);