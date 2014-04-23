Ezject
======

Macがスリープするときに外付けHDDをアンマウントするのと、スリープ解除時にマウントをする、常駐アプリ。

スリープとスリープ解除時に/usr/sbin/diskutilをNSTask経由でキックする。

ディスクの情報を取ってくるのが面倒だったので、

```
/usr/sbin/diskutil unmountDisk disk1
/usr/sbin/diskutil mountDisk disk1
```

を決め打ちでNSTask越しにキックするので、ディスクの増減には対応していない。

## Licence

This package was distributed under NYSL Version 0.9982, see LICENCE file for details.
