#Requires AutoHotkey v2.0

; 今回はDiscord専用にしたいので、Discordのウィンドウクラスを指定
#HotIf WinActive("ahk_exe Discord.exe")

; https://github.com/k-ayaki/IMEv2.ahk/blob/master/IMEv2.ahk   <- コピペ元

; IMEの状態の取得
;   WinTitle="A"    対象Window
;   戻り値          1:ON / 0:OFF
;-----------------------------------------------------------
IME_GET(WinTitle:="A")  {
    hwnd := WinExist(WinTitle)
    if  (WinActive(WinTitle))   {
        ptrSize := !A_PtrSize ? 4 : A_PtrSize
        cbSize := 4+4+(PtrSize*6)+16
        stGTI := Buffer(cbSize,0)
        NumPut("DWORD", cbSize, stGTI.Ptr,0)   ;   DWORD   cbSize;
        hwnd := DllCall("GetGUIThreadInfo", "Uint",0, "Uint", stGTI.Ptr)
                 ? NumGet(stGTI.Ptr,8+PtrSize,"Uint") : hwnd
    }
    return DllCall("SendMessage"
          , "UInt", DllCall("imm32\ImmGetDefaultIMEWnd", "Uint",hwnd)
          , "UInt", 0x0283  ;Message : WM_IME_CONTROL
          ,  "Int", 0x0005  ;wParam  : IMC_GETOPENSTATUS
          ,  "Int", 0)      ;lParam  : 0
}
; ここまでコピペ
; *****************************************************************************

; キーが押された回数
global count := 0

; ほぼ全てのキーが押された際の処理(半角/全角キー などは不要なので除く)
~*a::
~*b::
~*c::
~*d::
~*e::
~*f::
~*g::
~*h::
~*i::
~*j::
~*k::
~*l::
~*m::
~*n::
~*o::
~*p::
~*q::
~*r::
~*s::
~*t::
~*u::
~*v::
~*w::
~*x::
~*y::
~*z::
~*1::
~*2::
~*3::
~*4::
~*5::
~*6::
~*7::
~*8::
~*9::
~*0::
~*,::
~*.::
~*/::
~*;::
~*[::
~*]::
~*-::
~*=::
{
    global count
    count++
    
    ; 確認用
    ; ToolTip("countは: " . count)  ; カウントをツールチップで表示
    ; SetTimer () => ToolTip(), -2000  ; 2秒後にツールチップを消す

    return
}

; マウスクリックが押された場合
; クリックの後すぐにEnterを押すと送信されてしまうのを防ぐ
~LButton::
~RButton::
{
    global count
    count := 0
    return
}

; 半角/全角 が押された場合（「英語->ひらがな」ならcountを0にする）
~sc029::
{
    global count
    ; 押された瞬間のモードが取得できるので、「英語->ひらがな」の変更では「英語」が取得される
    imeMode := IME_GET()

    if (!imeMode) {
        count := 0
    }

    ; 確認用
    ; ToolTip("countは" . count . " / " . "imeModeは" . imeMode)
    ; SetTimer () => ToolTip(), -2000

    return
}

; Ctrl + V が押された場合
; コピペしてからすぐEnterを押したら送信されてしまうのを防ぐ
^v::
{
    global count
    count := 0
    SendInput "^v"
    return
}

; Enter が押された場合
Enter::
{
    ; 確認用
    ; ToolTip("countは: " . count)
    ; SetTimer () => ToolTip(), -2000

    global count
    imeMode := IME_GET()

    if (imeMode) {
        if (count == 0) {
            SendInput "+{Enter}"
        } else {
            SendInput "{Enter}"
            count := 0
        }
    } else {
        SendInput "+{Enter}"
        count := 0
    }

    return
}



; Ctrl + Enter が押された場合
^Enter::
{
    global count
    count := 0
    SendInput "{Enter}"
    return
}

#HotIf
