# Dir 清理规则

这个 Repo 用于存储 Yuuta 开发的 `kh.android.dir` [Dir 垃圾清理](https://coolapk.com/apk/kh.android.dir) 的清理规则。

## 目前暂不支持

- 匹配（所以无法支持微信垃圾的深度清理）

## 规则示例

提交 PR 请提交到 rules 目录下，我们会采用 GPL-3 保护您提交的规则的知识产权。

### 文件名及存储路径

示例： `/FOLDER.tencent/FOLDER.qqinput/FILE.recommend.xml.json`

表示在 `/sdcard` 下的 `/tencent/qqinput` 文件夹下有 **垃圾文件** `recommend.xml`

示例： `/FOLDER.tencent/FOLDER.tbrowserwificache.json`

表示在 `/sdcard` 下的 `/tencent` 文件夹下有 **垃圾文件夹** `tbrowserwificache`

*即：文件夹规则必须以 `FOLDER.文件夹名.json` 存储到对应 `FOLDER.` 开头的路径下，文件规则必须以 `FILE.文件夹名.json` 存储到对应 `FOLDER.` 开头的路径下。规则应当遵循严格的 JSON 格式。* 

### 规则内容

```json
{
  "mode": 0,
  "pkg": [],
  "willClean": false,
  "needUninstall": false,
  "notReplace": false,
  "carefully_clean": false,
  "carefully_replace": false,
  "authors": [
    ""
  ],
  "title": {
    "source": {
      "zh-rCN": "",
      "en-US": ""
    },
    "defaultSource": ""
  }
}
```

### mode - 规则分类

Int 类型, 非空。 该值将决定规则的分类，若指定，则应用将 **强制使用应用内置的默认清理策略** 。全自定义规则没有限制。

| int 值 | 对应类型描述 |
|:------:|:----------:|
| 0 | NONE，未指定类型，用于兼容老版客户端，禁止新提交的规则使用 |
| 1 | CACHE，应用缓存 |
| 2 | LOG，应用日志 |
| 3 | AD，应用广告 |
| 4 | UNINSTALL，应用卸载残留 |
| 5 | USER_DATA，用户数据 |
| 6 | CUSTOM，完全自定义 |

### pkg - 对应软件包 

String array,  可以为空，在数组内使用字符串类型存储对应规则关联应用的包名。

### authors - 作者

String array,  非空，在数组内使用字符串类型存储对应规则作者名。

### title - 清理规则说明

```json
"title": {
    "source": {
      "zh-rCN": "",
      "en-US": ""
    },
    "defaultSource": ""
  }
```

JSON object 类型，非空，内含多个字符串项。

`zh-rCN` 表示简体中文的规则说明，可以用 `zh` 替代，但不建议。
`en-US` 表示英文的规则说明。
`defaultSource` 表示非使用上述地区语言的用户显示的规则说明。

## 清理策略

```json
  "willClean": false,
  "needUninstall": false,
  "notReplace": false,
  "carefully_clean": false,
  "carefully_replace": false
```

均为 Boolean 类型，可取值: `true` / `false` ，非空。表格中为空表示没有默认设置。`MODE == 6` 时为完全自定义清理策略。

| mode |          | willClean | notReplace | carefully_clean | carefully_replace | needUninstall |
|:-----:|:--------:|:--------------:|:--------------:|:-----------------:|:-----------------:|:-----------------:|
| 对应分类值 | 英文分类 | 默认勾选清理 | 默认不建议替换 | 请谨慎清理 | 请谨慎替换 | 是卸载残留 |
| 0 | NONE | true | true | false | true |  |
| 1 | CACHE | true | true | false | true | |
| 2 | LOG | true | false | false | false | |
| 3 | AD | true | false | false | false |  |
| 4 | UNINSTALL | false | true | false | true |  |
| 5 | USER_DATA | false | true | true | true |  |
| 6 | CUSTOM | 完全自定义 | | | | |
