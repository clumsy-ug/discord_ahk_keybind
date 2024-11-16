# DiscordがEnterで送信されてしまう問題を解決するコード

# 動く環境
- Windows
  - Windows 11 Homeで挙動確認済み
- IMEはMicrosoft IME
  - Windows購入時にデフォルトになってるやつ（多分）

# 内容
- EnterではなくCtrl + Enterで送信されるようにした
- Enterは改行に割り当てた

- 日本語入力中（入力候補の検索窓が出ている状態）にEnterを押した場合
  - 従来のEnterが押されて確定される
- 入力確定後（すでにEnterを押しているため検索候補は出ていない状態）にEnterを押した場合
  - 従来のShift + Enterが押されて改行される
- 半角英数字モード

# カバーしていないこと
- Windowsでしか動かない
  - 挙動確認済みなのはWindows 11 Homeのみ
  - MacならKarabiner-Elementsを使えば良さそう
- Microsoft IME（最新？バージョン）のコードしか書いていない
- Discordでしか動かない