Ezject
======

Macがスリープして、復帰した時に外付けHDDが不正に取り外されたとのメッセージがでるため、

スリープ時に自動で外付けHDDをアンマウントする。

また、復帰時に自動でマウントをする。

メニューバーに常駐して、スリープと復帰のイベントを監視しています。

現状の制限事項として、マウント解除とマウントのコマンドをハードコードで書いてあるため、

外付けディスクの増減には対応してません。

仕組みとしては、スリープと復帰時に/usr/sbin/diskutilコマンドをNSTask経由でキックする。

ディスクの情報を取ってくるのが大変そう？だったので、下記のコマンドを直接キックしています。

```
/usr/sbin/diskutil unmountDisk disk1
/usr/sbin/diskutil mountDisk disk1
```

BSD系なので、Linuxと違って/procからデバイス情報を読んでくるとかできなかったので。。。

ちゃんとテストしていないのでうまく動くかわかりません。

## Licence

This package was distributed under NYSL Version 0.9982, see LICENCE file for details.
