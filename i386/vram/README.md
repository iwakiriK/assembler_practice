# VRAM上にアニメーションやドット絵を表示するプログラム   

　i386CPU用のアセンブリ言語を利用して，画面中央付近に配置されたキャラクターが画面上を左右に移動します．

アセンブルしてPCエミュレータbochsを起動することでVRAMの画面上で表示することができます．

本プログラムは次の1~4の処理をループさせています．

　1．VRAM上に表示されている内容を全て背景色で更新

　2．キャラクターを描写

　3．空ループを実行

　4．アニメーションの差分を更新

　キャラの座標は表計算ソフトを使って以下のように求めました．
![Image of coordinate]()

　容量削減のためvram.sにはサブルーチンは使用していませんが．サブルーチンを用いた場合のプログラムはvram2.sに記述してあります(512バイトを超えているので動きません)．

![Image of character](https://raw.githubusercontent.com/kut-info-pl2/q1-i386-leaners/master/vram/Screenshot.png?token=Ae-R-PYFhKxQ6gZev2XVEp17M_4pIh5yks5aEnaJwA%3D%3D)   