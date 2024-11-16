# 【Discord】Enterで送信されてしまうのを防ぐ

# 動く環境
- Windows
  - Windows 11 Homeで挙動確認済み
- IMEはMicrosoft IME
  - Windows購入時にデフォルトになってるやつ（多分）

# 内容
- EnterではなくCtrl + Enterで送信されるようにした
- Enterは改行に割り当てた

- 日本語入力中（入力候補の検索窓が出ている状態）にEnterを押した場合
  - 確定される（元々のEnterを割り当てた）
- 入力確定後（すでにEnterを押しているため検索候補は出ていない状態）にEnterを押した場合
  - 改行される（元々のShift + Enterを割り当てた）
- 半角英数字モードでEnterを押した場合
  - 改行される（元々のShift + Enterを割り当てた）

# カバーしていないこと
- Windowsでしか動かない
  - 挙動確認済みなのはWindows 11 Homeのみ
  - MacならKarabiner-Elementsを使えば良さそう
- 新しいMicrosoft IMEでしか動かない
  - 具体的なバージョンはまだ調べていないのでわからない
- Discordでしか動かない