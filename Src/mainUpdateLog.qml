﻿import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.14
import QtQuick.Dialogs 1.2 as Dialog1
import QtQuick.Layouts 1.14


//import cn.Leamus.MakerFrame 1.0


import _Global 1.0
import _Global.Button 1.0


//import RPGComponents 1.0


import 'qrc:/QML'


//import './Core'


//import 'File.js' as File



Rectangle {
    id: root

    signal s_close();


    //width: 600
    //height: 800
    anchors.fill: parent

    clip: true
    focus: true

    color: Global.style.backgroundColor



    MouseArea {
        anchors.fill: parent
    }



    ColumnLayout {
        width: parent.width * 0.96
        height: parent.height * 0.96
        anchors.centerIn: parent

        Notepad {
            id: msgBox

            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignHCenter// | Qt.AlignTop
            //Layout.preferredHeight: 50
            Layout.maximumHeight: parent.height
            Layout.fillHeight: true


            text: ''

            textArea.color: 'white'
            textArea.readOnly: true

            textArea.selectByMouse: false

            textArea.font {
                pointSize: 15
            }

            textArea.background: Rectangle {
                //implicitWidth: 200
                //implicitHeight: 40
                color: "#80000000"
                //color: 'transparent'
                //color: Global.style.backgroundColor
                border.color: msgBox.textArea.focus ? Global.style.accent : Global.style.hintTextColor
                border.width: msgBox.textArea.focus ? 2 : 1
            }
        }

        Button {
            //Layout.fillWidth: true
            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignHCenter// | Qt.AlignTop
            Layout.preferredHeight: 50

            text: "返回"
            onClicked: {
                s_close();
            }
        }
    }



    //Keys.forwardTo: []
    Keys.onEscapePressed: {
        s_close();

        console.debug("[mainUpdateLog]Escape Key");
        event.accepted = true;
        //Qt.quit();
    }
    Keys.onBackPressed: {
        s_close();

        console.debug("[mainUpdateLog]Back Key");
        event.accepted = true;
        //Qt.quit();
    }
    Keys.onPressed: {
        console.debug("[mainUpdateLog]key:", event, event.key, event.text)
    }



    QtObject {
        id: _private

    }

    //配置
    QtObject {
        id: config
    }





    Component.onCompleted: {
        let t = `
<CENTER><B>更新日志</B></CENTER>
2023/12/17：发布 1.6.25.231217 版本
1、修复一些小bugs；
2、调整和优化代码细节，调整部分指令（game.createhero、game.hero、game.createrole、game.role、game.rolepos）；
3、角色编辑器增加是否显示名字；

2023/12/13：发布 1.6.24.231213 版本
1、增加载入地图前后自定义运行脚本；
2、修复一些bugs；
3、调整和优化代码；

2023/12/6：发布 1.6.23.231206 版本
1、修复选择技能/道具框风格无效问题；
2、修复自动攻击时第一次无动作bug；

2023/12/5：发布 1.6.22.231205 版本（框架 1.3.23.231205 版本）
1、修复getFightRoleObject的隐形Bug；
2、调整引擎目录结构，将通用组件放在RPGComponents；
3、修复点击障碍物会乱跑Bug；
4、修复插件下载错误Bug；

2023/12/3：发布 1.6.21.231203 版本
1、优化代码：分离出地图组件（GameMapView），合并run，调整其他命令兼容run；
2、修复一些字体颜色不起作用的问题；
3、修复使用技能减少MP时最后一次无法释放Bug；
4、增加使用统计功能；

2023/11/30：发布 1.6.20.231130 版本
1、新增代码缩进功能；
2、修复一些小问题；
3、修复配置文件中文乱码和读取配置的一个小bug；
4、调整可视化界面细节；
5、增加字体配置；

2023/11/29：发布 1.6.19.231129 版本（框架 1.3.22.231129 版本）
1、新增代码高亮提示；
2、恢复血条长度；
3、增强FrameManager文件操作；
4、误删文件自动修复（QML/LGlobal）；
5、优化代码；

2023/11/28：发布 1.6.18.231128 版本
1、修复game.addprops的bug；
2、增加战斗人物头顶自定义状态条；
3、大幅调整部分代码，优化和修复；

2023/11/26：发布 1.6.17.231126 版本
1、修复game.addprops的bug；
2、修改了refresh函数；
3、优化代码；

2023/11/25：发布 1.6.16.231125 版本
1、优化代码；
2、修复若干小问题；

2023/11/24：发布 1.6.15.231124 版本（框架 1.3.21.231124 版本）
1、调整 自定义可视化命令的编译运行函数的参数和处理方式，并优化一个小问题；
2、调整游戏窗口的4个顶层窗口和战斗窗口的3个顶层窗口组件名；
3、调整和修复一些路径问题；

2023/11/16：发布 1.6.14.231116 版本
1、调整game.showsprite和game.showimage的$parent含义和$x、$y、$width、$height含义；
2、调整通用脚本的配置（名称、prototype、预留槽）；
3、优化升级脚本；

2023/11/14：发布 1.6.13.231114 版本
1、修复一个小问题；
2、修改game.setscenerole指令，使之支持地图移动（非跟踪角色）；
3、修改游戏整个布局设定：修改和新增 地图场景的 game.$sys.screen、game.$sys.viewport、game.$sys.scene、game.$sys.map 四个层次和 战斗场景的 fight.$sys.screen、fight.$sys.viewport、fight.$sys.scene 三个层次，可以修改场景大小来进行留白给插件使用；

2023/11/09：发布 1.6.12.231109 版本
1、继续将一部分战斗代码放入通用脚本，供自定义玩；
2、修复乱封眠的错误；
3、优化代码；

2023/11/07：发布 1.6.11.231107 版本（框架 1.3.20.231107 版本）
1、调整适配全部UI，做了亮色和暗色两套主题；
2、可自定义风格（默认Material）；
3、修复报错系统；
4、修复 乱 无效果问题；
5、修复血量Bugs（判定将$properties.HP全部改为$$propertiesWithExtra.HP，需要改通用脚本）；
6、将战斗按钮抽象到通用脚本，可自定义；
7、优化代码；

2023/11/05：发布 1.6.10.231105 版本
1、增加耗时载入的忙碌提示；
2、优化代码和脚本队列；

2023/11/04：发布 1.6.9.231104 版本
1、修复个小Bug（主角$targetX和$targetY写错）；
2、增加主角和角色定向移动类型（$targetBlocks和$targetPositions为数组，$targetBlockAuto为自动寻路）；
3、增加A*算法；
4、移动start脚本里的init、save和load函数 到 通用脚本的gameInit、beforeSave、beforeLoad、afterSave、afterLoad函数；

2023/11/02：发布 1.6.8.231102 版本
1、修复读取存档黑屏Bug；
2、增加选择步骤菜单类型；
3、所有编辑器加入退出提示；
4、增加插件自动/非自动加载机制，增加game.plugin('作者', '插件名')来更安全的使用插件；
5、优化代码；

2023/11/01：发布 1.6.7.231101 版本
1、增加自定义战斗人物顺序模式（可修改为按属性比较来获取多次机会）；
2、大幅优化代码；

2023/10/27：发布 1.6.6.231027 版本
1、修复一些战斗中战斗人物上下场功能小问题（下场后可能还会战斗）；
2、优化相同地图载入时可以不再重新绘制；
3、修复互动按钮触发地图事件Bug；
4、强化脚本队列的下一次事件执行功能；

2023/10/25：发布 1.6.5.231025 版本
1、增加禁止操作主角功能；
2、优化代码；
3、修复战斗进入卡死Bug；
4、增加战斗中战斗人物上下场功能；

2023/10/18：发布 1.6.4.231018 版本
1、增加几种简单的加密方式；
2、增加hero和role的pos和direction函数；
3、优化代码；

2023/10/16：发布 1.6.3.231016 版本
1、修复NPC无法碰撞问题；
2、修复地图点击移动鬼畜问题；
3、修复右键单击地图失去焦点问题；
4、调整代码，将资源相对路径都改为绝对路径（Linux的GStreamer不支持相对路经），适配了openKylin系统（Linux的Debian分支 应该都可以）；
5、修复部分bugs（包括：JSEngine的文件路径问题导致调试错误；战斗道具的使用等）；
6、调整战斗选择系统（Filter参数 更自由化） 和 道具可使用多个技能（选择系统为choiceScript或第一个道具的选择系统）；


2023/10/13：发布 1.6.2.231013 版本
1、调整优化部分战斗代码；

2023/10/10：发布 1.6.1.231010 版本（框架 1.3.19.231010 版本）
1、战斗选择系统重写，新选择系统支持技能各种花式自定义选择，配合技能播放能做出非常丰富的效果；
2、优化很多代码，修复一些bug（地图半透明Bugs）；

2023/9/22：发布1.5.6.230922版本
1、修复、调整道具check调用顺序；
2、完全修复音乐音效问题；
3、调整战斗的一些代码；
4、调整game.run和fight.run命令，删除script命令（整合）；
5、增强代码错误逻辑；
6、修复安卓打包；

2023/9/15：发布1.5.5.230915版本
1、修复修改人物名称Bug；
2、去掉win版启动时的cmd窗口；

2023/9/13：发布1.5.4.230913版本
1、修复插件运行Bug；
2、调整游戏初始化顺序；
3、修复后台音效不关闭Bug；
4、修复插件运行多次、卸载错误；

2023/9/12：发布1.5.3.230912版本
1、修正音乐音效问题，增加全局音乐音效配置；
2、调整游戏主定时器运行机制；
3、修复移速问题；

2023/9/11：发布1.5.2.230911版本
1、增加NPC地图事件和地图事件全局函数；
2、细节优化（NPC点击事件默认为移动到跟前、切换地图后主角停止动作）；
3、其他代码优化；

2023/9/10：发布1.5.1.230910版本
1、增加 smooth配置（缩放地图、特效、角色时是否平滑还是按像素）；
2、增加 提前载入全部资源（默认是不全部）；
3、修复一些小Bug，优化大量代码；

2023/9/8：发布1.4.25.230905版本（框架 1.3.18版本）
1、终于解决N个闪退问题的Bug：
  Qt5.15.2以上的版本，多次使用Async的run会闪退（目前到5.15.10也是如此）；
  线程创建Qt对象导致的信号连接失效；
  其他线程执行 QML中连接的信号并执行，导致闪退；

2023/9/5：发布1.4.25.230905版本（框架 1.3.17版本）
1、修复宠物上场技能无效Bug；
2、增强自定义可视化脚本（可以自己写函数来制作指令字符串）；
3、自定义可视化脚本可以在每个脚本编辑器中切换；
4、限制脚本队列最大上线2000个（之前可能会导致闪退）；
5、限制文本框的行数（之前可能会导致卡顿）；
6、修复一些Bugs；

2023/8/31：发布1.4.24版本
1、增强可视化脚本：对齐序号，加入复制粘贴命令，可以拖动较长命令；
2、修复大量Bug（主要是事件问题）；

2023/8/30：发布1.4.23版本
1、将战斗事件独立出来，应该解决了很多隐形bug；

2023/8/26：发布1.4.22版本
1、修复5个编辑器的另存为时可视化数据不会复制；
2、调整了5个可视化编辑器的保存格式（兼容旧格式）；

2023/8/22：发布1.4.21版本（框架 1.3.16版本）
1、补充战斗技能的倍率参考属性栏；
2、将离线环境打包进包（优先读取下载版）；
3、支持存档压缩；

2023/8/19：发布1.4.20版本
1、小调整 game.fighthero 函数；
2、修复个小Bug；

2023/8/16：发布1.4.19版本
1、修复地图编辑器无法删除资源；

2023/8/14：发布1.4.18版本
1、修复重复打开应用出错问题；
2、修复战斗初始化Bug导致战斗人物无法选择或无法战斗；
3、修复game.equip命令错误；

2023/8/12：发布1.4.17版本
1、增加声音、音效保存；
2、增加可视化编程的测试功能；
3、调整QML内核；
4、修复一些Bugs；

2023/8/11：发布1.4.16版本
1、修复一些Bug，增强暂停和恢复指令；

2023/8/10：发布1.4.15版本（Updater 1.5.10版本，框架 1.3.14版本）
1、继续适配BT的隐私政策和权限（从QML隐私到C++隐私，再到安卓新建Activity隐私做了一遍）；
2、修复获取存储权限Bug；
3、优化；

2023/8/6：发布1.4.14版本
1、大量优化内核、修复Bugs；
2、适应Tap隐私政策和权限；
3、增强 道具、角色 描述（可以动态计算）；

2023/7/28：发布1.4.13版本
1、修复小bug；
2、将样式全部提取出来供修改（包含msg、input、say、talk等）；
3、将战斗菜单提取出来供修改；

2023/7/25：发布1.4.12版本
1、修改战斗脚本的fightScript为对象；
2、增强可视化脚本的显示；

2023/7/24：发布1.4.11版本
1、修复物品使用技能bug；

2023/7/20：发布1.4.10版本（Updater 1.5.8版本，框架 1.3.12版本）
1、增加Tap防沉迷认证回调机制；
2、修复N多Bugs；

2023/7/16：发布1.4.9版本
1、修复Bugs、优化代码s；

2023/7/10：发布1.4.8版本
1、增加地图跟随角色命令；
2、新增WebView组件；
3、优化代码、修复Bugs；

2023/7/2：发布1.4.7版本
1、地图遮挡支持透明度设置；
2、暴露一些常用组件供修改；

2023/6/30：发布1.4.6版本
1、地图角色支持播放动作（sprite）；
2、优化代码；

2023/6/29：发布1.4.5版本（Updater 1.5.6版本，框架 1.3.9版本）
1、优化代码（安卓Java的）；
2、将战斗时位置函数分离出来；

2023/6/26：发布1.4.4版本（Updater 1.5.5版本，框架 1.3.8版本）
1、修复小bug；

2023/6/24：发布1.4.3版本（Updater 1.5.4版本，框架 1.3.7版本）
1、集成Tap库；
2、优化、更新、加强、修复。。。

2023/6/23：发布1.4.2版本
1、集成Bacon2d库；

2023/6/21：发布1.4.1版本
1、修正一些Bugs；
2、集成Box2d-qml库；

2023/6/18：发布1.3.3版本
1、修正了一些Bugs；
2、角色加入$id属性，$name名字可以重复了（为了兼容之前代码，$id默认是$name，但$id和$name可以设置其中一个，也可省略或都设置；如果要起同名NPC，则必须设置$id）；

2023/6/4：发布1.3.2版本
1、修正了一些错误；
最近两个月，我生活和工作上遇到了很多事情，感觉仿佛到了人生最低谷，让我身心俱疲，所以引擎更新慢了很多，待我再鼓起勇气解决这一切问题时，再继续努力！

2023/5/4：发布1.3.1版本
1、优化插件和可视化目录结构；

2023/4/22：发布1.2.18版本
1、交易加入翻页；
2、加入本地载入插件（插件可以支持项目的任何资源、脚本等）；

2023/4/21：发布1.2.17版本
1、加入角色穿透属性；
2、加入角色碰撞事件；

2023/4/19：发布1.2.16版本
1、将 交互和菜单 按钮也改为可选；
2、分离4个组件（交易、系统、背包、战斗人物信息）并作为插件，可供二次修改；

2023/3/14：发布1.2.15版本
1、修复敌人装备道具时的HP、MP值；
2、改变买卖道具时双击弹出批量购买弹窗；

2023/2/28：发布1.2.14版本
1、将人物信息作为可拖动；
2、修复音效关闭人物叫喊出声问题（感谢吾爱）；
3、修复可视化的一个小Bug（感谢落雪）；
4、修复HP和MP的恢复Bug（感谢吾爱）；

2023/2/17：发布1.2.13版本
1、将战斗人物的数据从$commons改回$createData（傻了，导致所有人物公用属性了；

2023/2/15：发布1.2.12版本
1、修复地图编辑器的小Bug；
2、将所有可视化道具、技能、战斗人物、战斗脚本的数据从$createData移动到$commons（主要是考虑到可视化不需要保存数据）；

2023/2/14：发布1.2.11版本
1、修复可视化技能生成Buff错误；
2、修改战斗人物、战斗脚本、道具和技能的继承链，先读$createData产生的数据（存档），如果没有再读$commons的数据（代码固定）；
3、修复game.talk命令小bug；

2023/2/13：发布1.2.10版本
1、修复地图事件执行后影响后续事件的Bugs；
2、优化载入地图卡顿时人物行走更顺滑；
3、优化异步脚本队列逻辑；
4、优化遮罩透明时可操作摇杆；

2023/2/11：发布1.2.9版本
1、加入安卓两键打包功能（由于服务器带宽限制、精力有限先不做一键）；

2023/2/10：发布1.2.8版本
1、修了一些game.pause、goon逻辑小问题；
2、修复进入战斗卡死问题；

2023/2/9：发布1.2.7版本
1、更换图形组件，支持gif图片；
2、修复载入存档时装备丢失bug；

2023/2/8：发布1.2.6版本
1、修复游戏结束运行报错问题；
2、修复游戏开始时组件为初始化完毕游戏就使用的bug；
3、调整Global的一些函数；
4、适应游戏资源打包后的载入；

2023/2/7：发布1.2.5版本
1、修复一些Updater的Bugs；
2、重新发布 win 的框架引擎；
3、修复可视化的一个问题；
4、发布新安卓打包环境；

2023/2/6：发布1.2.4版本
1、发布新版apk；
2、地图编辑器可以调地板层；
3、修正一些小问题；

2023/2/5：发布1.2.3版本（框架 1.3.3版本）
1、大幅调整目录结构、修改代码变量名称和文件名；
2、修改QML的LGlobal的路径、项目路径、资源路径；
3、调整 Updater 的界面和显示；

2023/2/4：发布1.2.2版本
1、修复 测试地图 时修改脚本无效的问题；
2、增强游戏退出时的资源释放；
3、优化地图编辑器和可视化编辑器的小细节；

2023/2/3：发布1.2.1版本（Updater 1.5.1版本）;
1、加入 RPGMaker 离线编辑功能；
2、升级Updater：创建Application前可以用配置文件去修改环境变量和属性；

2023/2/1：发布1.1.30版本
1、增强 game.rolepos 命令；
2、修改game.playmusic参数；
3、修改地图事件多次执行bug；
4、加入地图块离开事件（事件名_leave）；

2023/1/31：发布1.1.29版本
1、修正 战斗角色 模板错误；
2、修改可视化编程的参数检查为可选；
3、修正所有布局警告（终于趟过了Layout的坑）；

2023/1/30：发布1.1.28版本
1、win版本的64位采用Msys的5.15.8发布，有效解决了卡死Bug问题；
2、修正图片和特效显示坐标问题；
3、小调整和优化；

2023/1/29：发布1.1.27版本
1、解决64位莫名其妙卡死退出问题（费尽千辛万苦）；
2、优化升级加载器架构；
3、window加入标题；
4、临时修复NPC转向问题（QML的坑）；

2023/1/28：发布1.1.26版本
1、增加可视化编程的参数错误判断和提示；
2、增强插件功能，可以使用插件进行创建界面、指令等各种功能，甚至可以跳过引擎直接新建一个新引擎！
3、将两个窗口的样式分离到了通用脚本中；

2023/1/27：发布1.1.25版本
1、修复游戏错误就无法退出的问题；
2、增加两个事件（菜单开关）；
3、小调整game.window指令（加入style参数）；
4、修复按钮的一个小Bug；
5、增加 game.menu 的style参数；
6、增加 game.window 的style参数；

2023/1/26：发布1.1.24版本
1、加入退出游戏提示；
2、小优化、小调整代码；
3、修复道具可视化小Bug；
4、道具使用加入使用函数；
5、大更新：游戏场景支持自定义QML和JS组件，是一种扩展功能；

2023/1/24：发布1.1.23版本
1、优化代码；
2、修复若干Bugs；
3、加入了 game.seekmusic 命令；

2023/1/23：发布1.1.22版本
1、增加使用协议；
2、增加脚本编辑器，可随意新建脚本和可视化脚本，也可以编写、设计插件；
3、调整插件目录名称；
4、设计了升级链可视化插件；
5、小调整指令和名称；
6、修复文本框闪退问题（原因未知，估计是Qt的Bug，在QmlCreator中好不容易找到了避开的解决办法）；

2023/1/21：发布1.1.21版本
1、修复可视化道具的几个Bug；
2、修复技能的我方全体错误逻辑；
3、修复道具技能无法释放的Bug；

2023/1/20：发布1.1.20版本
1、修复窗口显示bugs；
2、加入自动战斗也可以换技能、道具等；

2023/1/19：发布1.1.19版本
1、新增 http 联网访问协议（没有同源限制，可以访问本地接口，其实就是 XMLHttpRequest对象，但是 QML 中只实现了 XMLHttpRequest Level 1 标准）；
2、新增 game.window 命令；
3、修复初始化脚本的运行问题（感谢 泥岩厨没泥岩很正常吧(哭)）；

2023/1/18：发布1.1.18版本
1、修复 技能可视化 读取Bug；
2、增加 qnanopainter库，基于opengl的QPaint方式绘图，绘图效率非常高！
3、修复敌人音效问题；
4、列表加入搜索（更方便了）和滚动条；
5、增加地图大小和视窗大小的变量；

2023/1/17：发布1.1.17版本
1、修复点击精灵和地图顺序Bugs；
2、增加简易画图测试小功能（经测试效率并不高）；

2023/1/16：发布1.1.16版本
1、删除了一些无用代码；
2、调整一些代码结构；

2023/1/15：发布1.1.15版本
1、增加主角和角色定向移动功能；
2、完善脚本系统的一个小问题；
3、增加地图点击事件；
4、增加主角点击行走功能；
5、优化战斗时角色创建代码；
6、加入存档、读档回调函数（在start.js脚本里）；
7、小优化地图编辑器（加入图层半透明、坐标显示）；
8、优化脚本执行系统；
9、加入战斗初始化函数（通用和战斗脚本中），可以制作特殊上下战斗角色需求；
10、修复技能回合数有效Bug，调整战斗人物回合脚本为3个阶段；

2023/1/14：发布1.1.14版本
1、修复名字显示小Bug；
2、微调 talk 命令；
3、调整战斗脚本的指令、函数名和可视化；

2023/1/13：发布1.1.13版本
1、加入自定义可视化命令；

2023/1/12：发布1.1.12版本
1、小调整playvideo命令；

2023/1/11：发布1.1.11版本
1、修复一些小Bug；
2、设置中增加音乐和音效的打开和关闭；

2023/1/10：发布1.1.10版本
1、完善showimage、showsprite命令；
2、修复一些小Bug（视频播放大小等等）；

2023/1/9：发布1.1.9版本
1、修复可视化的一个警告错误；
2、增强 addprops 命令；
3、调整 showimage、playvideo、showsprite 命令；
4、调整 game.input 命令；

2023/1/8：发布1.1.8版本
1、微调特效代码；
2、增强 addprops 指令 和 showimage 指令；
3、修复PC端人物偶尔自动走路Bug（焦点问题）；
4、微调可视化编程界面；
5、增加 game.input 命令；

2023/1/7：发布1.1.7版本（框架1.3.2版本）
1、修正热更新框架的小Bug；
2、可视化加入缩进颜色，优化体验；
3、修复game.showimage一些bug；
4、修复属性buff不会消失bug；
5、修复msg、talk、say不能显示数字和显示空字符串卡死的bug；

2023/1/6：发布1.1.6版本
一些小调整优化；

2023/1/5：发布1.1.5版本
1、修复所有特效战斗人物共享一个移动动画的问题；
2、增加 延时 可视化命令；

2023/1/4：发布1.1.4版本
1、增加按键自定义图片；
2、一些小调整；
3、修正技能可视化的一些Bug和逻辑；
4、可视化脚本加入播放视频、图片、特效等6个命令；

2023/1/3：发布1.1.3版本
1、增加NPC点击事件；
2、修复一些严重Bugs（战斗）；
3、修复技能可视化的很多Bugs；

2023/1/2：发布1.1.2版本
1、修复Buff的一些Bug；
2、增加自动攻击选项；
3、增加 game.control 命令；
4、修复战斗N多Bug、双击装备弹出道具Bug；

2023/1/1：发布1.1.1版本
1、元旦快乐！
2、道具加入翻页功能（20个一页）；
3、加入自定义遥感和按钮配置，可增加自定义按钮；
4、加入可自定义屏幕方向；
5、修改战斗动画时可重新选择战斗人物攻击、技能或道具，这样可以支持放置类游戏（经测试已经成功，既可以全局放置，还可以单独某一场战斗放置）；
6、优化代码，修复一些Bugs；

2022/12/31：发布1.1.0版本
1、角色加入横纵轴缩放；
2、完善道具可视化；
3、增强addprops指令功能；
4、完善其他可视化脚本功能；
5、修复每回合回复血量、偶尔出现重复上次异常、行走异常 等若干Bugs；

2022/12/30：发布1.0.4版本
1、修改fighting和fighton的命令（不影响原调用）；
2、增加可视化fighting的回调函数；
3、完善技能可视化；
4、修复若干Bugs；
5、加入角色名字在头上；
6、修正可视化小问题；
7、发布安卓64位版本；

2022/12/29：发布1.0.3版本
1、修复战斗有概率卡死的问题(continueHuiHe被递归运行了）（感谢 随便逛逛）；
2、修复菜单自适应问题；
3、没有的特效会自动忽略，不会报错了；
4、Message组件，会自动向下滚动；

2022/12/28：发布1.0.2版本
1、修复可视化脚本的符号显示问题（HTML代码）；

2022/12/27：发布1.0.1版本
1、修复战斗技能可视化的一个Bug，和战斗的一个Bug（感谢 落雪）；
2、加入 可视化界面 退出提示保存功能；
3、修复普通攻击没选目标直接重复上次的Bug（感谢 吾爱）；
4、修复可视化脚本界面的 TextArea 颜色问题 和 一个弹出框问题，和注释问题（感谢 落雪）；
5、修复可视化删除框时退出产生的Bug（感谢 落雪）；

<font color='red'>2022/12/26：发布1.0.0版本</font>
1、修复角色面向问题；
2、增加记忆工程；
3、优化其他一些小细节；
发布1.0.0正式版！！！

2022/12/25：发布0.16.9版本
1、起始脚本加入模板（可视化脚本不使用默认*start方法时启用）；
2、修改 FightRole的Anctions编辑模式和使用方式（放在脚本$commons.$actions方法中）；
3、加入引擎的道具、战斗人物和技能的对象继承链：道具和技能对象继承自脚本的data对象；战斗人物对象继承自脚本的data对象，data对象继承自$Combatant方法（创建顺序也是）；
4、增加技能、道具可视化编辑器；
5、完善战斗角色和战斗脚本的可视化编辑；
6、修复N多Bug（感谢 落雪 发现的3个Bugs）；
7、其他细节优化；
准备明天正式发布！

2022/12/22：发布0.16.6版本
1、修改 图片、音乐和视频资源管理器，删除了繁琐多余的资源对应，直接是文件目录的简单管理，对应的backgroundImageIRd、musicRId都改为 文件名（文件资源相对目录为 本项目工程\Resources\下的各类型文件夹）；
2、背包中增加了剧情类；
3、特效和角色编辑器，修改参数时会自动刷新；
4、增加 战斗角色和战斗脚本的可视化编辑；
5、重定义了 道具图形、角色头像、战斗角色头像 的图片相对目录（都为 Resources\Images）；
6、talk命令加入了头像；
7、say命令支持我方角色；
8、角色编辑器加入了头像和大小；
9、修复了角色编辑器无法保存等很多其他Bugs；
10、修改showimage、playmusic、playvideo支持网络资源播放，丰富参数传递；
11、video支持单击暂停、双击关闭；

2022/12/20：发布0.16.5版本
1、优化图片、音乐、视频编辑器操作；
2、优化其他小地方；
3、修复game.scale场景偏移问题；
4、修复某些地图场景显示偏移问题；

2022/12/18：发布0.16.4版本
1、修复商店售卖物品无限增加Bug；
2、start脚本增加init函数，修复载入存档时不会运行初始化代码的Bug；
3、优化游戏存档载入速度（不再重新载入资源）；
4、随机战斗也可以进入存档；
5、修复两个 属性 函数错误；
6、修复 装备无法 $check 错误；
7、优化背包功能；

2022/12/17：发布0.16.3版本
1、合并 game.addgtimer 到 game.addtimer、game.delgtimer 到 game.deldimer；
2、增加技能和道具选择事件；
3、修复战斗动画Bug；
4、修复一个很奇怪的菜单Bug；
5、修复 game.skill 返回Bug；
6、优化N多代码；

2022/12/16：发布0.16.2版本
1、增强游戏暂停功能；
2、修复战斗动画一些Bug；
3、优化代码；

2022/12/16：发布0.16.1版本
1、重新设计了脚本系统，已经非常完美了（支持即时运行、队列运行和插队运行）；
2、修正N多Bug（包括战斗音效突然消失问题）；
3、优化代码；

2022/12/12：发布0.15.1版本
1、将 say指令改为talk指令；
2、say指令重新定义为某个人物头上的说话；

2022/12/10：发布0.14.1版本
1、大幅修改内核，修改了很多名称（带$的一般表示系统使用，带$$的表示系统使用且不会保存），增强了战斗人物的三段属性（每个属性都可以两段或三段），将战斗人物一些属性、升级相关代码移出内核，放入外部供自定义；

2022/12/9：发布0.13.1版本
1、加入道具技能（战斗时使用道具）；
2、增强了一丢丢脚本队列系统（加入脚本说明，让调试简单点）；
3、修改了 game.createfighthero、game.getskill、game.getgoods指令的参数；
4、修正N多Bug，优化N多代码；

2022/12/5：发布0.12.6版本
1、增强 game.msg 的功能；
2、增加人物头像的显示；

2022/12/3：发布0.12.5版本
1、增加了道具图片和道具名颜色；
2、增加 game.msg、game.say 的自定义样式；
3、增加几个功能：game.$projectpath、$gameMakerGlobal、$config；
4、增加msg、say命令支持空格和回车自动转换；
5、修复几个Bug；

2022/11/30：发布0.12.4版本
1、增加 rolepos 来获取角色坐标；
2、美化了坐标界面；
3、修复2个小BUG；
4、增加 game.$userscripts 指令；
5、修复hp、mp上限小问题；

2022/11/29：发布0.12.3版本
1、大幅增强背包界面可操作性；
2、合并战斗脚本enemiesData的两个字段；
3、修改了很多命名相关细节的东西；
4、修复音乐播放Bug；

2022/11/27：发布0.12.2版本
1、修复几个Bug；
2、增强game.goods、game.removegoods、game.skill指令；
3、修复Message组件显示富文本Bug；
4、调整game.say指令参数；

2022/11/27：发布0.12.1版本
1、加入了Buff系统（内置毒乱封眠属性 5种Buff，可以按需要自己设计）；
2、重构了60%左右的 技能系统；
3、调整两个命令：setmap改为movehero，fight改为fighting；
4、增加修改地图角色属性；
5、修复N多Bug；
6、功能基本全部完成，接下来就是无尽的调整、优化和修复；等大体没问题，就出正式版了。

2022/11/22：发布0.11.6版本
1、增强了可视化界面的命令（判断、循环、函数 这些命令会完整显示）；
2、修复1个小Bug（感谢吾爱）；

2022/11/20：发布0.11.5版本
1、增强道具、技能和战斗脚本的创建方式（加入参数）；
2、做出 放置类 DEMO；
3、修复一些BUG；

2022/11/19：发布0.11.4版本
1、修复战斗的一些BUG和重复上次战斗；

2022/11/18：发布0.11.3版本
1、修复装备的两个BUG（感谢 吾爱）；

2022/11/12：发布0.11.2版本
1、继续完善了引擎内核；

2022/11/11：发布0.11.1版本
1、大幅修改引擎内核，将道具、技能实例化（之前只是引用），这样好处是可以做一个模板不同属性的道具或技能，也叫随机道具；
2、调整相关指令，增加 game.removegoods 指令；
3、修复N多BUG；

2022/11/9：发布0.10.15版本
1、日常修复Bug。。。;
2、增加 game.skill 指令；

2022/11/8：发布0.10.14版本
1、增加敌人掉落道具；
2、调整了消息框显示效果和msg指令；
3、删除game.hasgoods，加强 game.goods 指令（可以替代hasgoods）；

2022/11/5：发布0.10.13版本
1、修改了战斗结束脚本参数和通用战斗脚本参数；
2、修改了导出地图图片的路径（Output/Maps），这样好删除一些；
3、修复战斗敌人出现算法的Bug（感谢 吾爱 提供）；
4、修复其他一些Bugs；

2022/11/3：发布0.10.12版本
1、修复地图缩放后产生黑线条BUG；
2、优化一些繁琐的界面；
3、优化可视化一些界面的布局；
4、可自定义战斗角色属性名称和某些算法；
5、加入了简单的中文编程方式（主要是战斗人物属性方面，比如 战斗人物对象.$$属性('属性名')）；

2022/11/2：发布0.10.11版本
1、优化一些代码；
2、修复教程的一些错误；
3、增加十几条可视化命令，基本包含了所有常用命令了；
4、删除delallroles和delallheros指令（功能合并到相关del指令）；

2022/11/1：发布0.10.10版本
1、修复一个严重的BUG；
2、修复交易的道具只能显示两行文本的BUG；
3、修改了伤害方案：伤害算法只是用来计算，实际使用是技能脚本；
4、增强了game.fighton指令；

2022/10/30：发布0.10.9版本
1、修复一些BUG；
2、调整game.fighton指令参数；
3、调整可视化指令 简易运算；

2022/10/28：发布0.10.8版本
1、可视化加入了运算符、简易运算、与或非 指令；
2、加入了一些帮助（H按钮）；
3、修复战斗角色界面问题；

2022/10/25：发布0.10.7版本
1、完善了一些细节；

2022/10/24：发布0.10.6版本
1、修复可视化脚本的一些BUG；
2、完善可视化脚本的编译缩进；
3、完成指令分组和颜色；

2022/10/23：发布0.10.5版本
1、可视化脚本加入条件、循环、判断等指令；
2、可视化加入缩进效果；
3、可视化增加启用、禁止 指令（相对于脚本的注释）；
4、可视化加入长按可以选择预选值的功能；
5、修复一些BUG；

2022/10/22：发布0.10.4版本
1、可视化脚本加入函数、变量指令；

2022/10/20：发布0.10.3版本
1、地图编辑器加入可视化脚本；

2022/10/19：发布0.10.2版本
1、可视化脚本加入很多指令，包括自定义指令；

2022/10/18：发布0.10.1版本
1、加入可视化脚本Demo，目前只能在开始脚本中使用，先测试一下（花了两天时间搞出来的。。）；

2022/9/29：发布0.9.4版本
1、将两个函数放入通用脚本（创建战斗角色和计算装备属性）；

2022/9/26：发布0.9.3版本
1、修复交易BUG；
2、继续加强脚本系统（可以优先执行）；
3、给DEMO加入了一些音乐；

2022/9/20：发布0.9.2版本
1、修复一些BUG；
2、回合时增加一个回合结束事件；

2022/9/12：发布0.9.1版本
1、全面修改脚本编辑系统，用了一个奇淫技巧实现的，目前可以用三方编辑器来直接编辑所有的js脚本文件了；之前的工程需要大改一下才能继续用（主要是将json中的脚本提取为js）；
2、增强脚本系统；
3、增加了JS引擎管理系统；
4、修复N多BUG；

2022/9/10：发布0.8.34版本
1、修改指令 getexp 为 addprops；
2、修复BUGs；
3、增加恢复类技能；
4、完善升级链；

2022/9/8：发布0.8.33版本
1、完善战斗技能选择、逃跑和属性；
2、加入命令 game.gameover；
3、加入游戏结束脚本；

2022/9/6：发布0.8.32版本
1、加入 图片、视频 管理器 和预览；
2、游戏中加入显示图片、播放视频 功能和命令：game.showimage、game.delimage、game.playvideo、game.stopvideo；
3、战斗背景完善；
4、战斗模式完善；
5、战斗角色编辑预览完善；

2022/9/3：发布0.8.31版本
1、修改部分内容，为Windows和Android打包做准备；
2、经几天研究，解决了打包的部分技术问题，可以相对完美的生成Win平台的项目和安卓的APK生成（需借助三方应用来打包签名一下）；
3、修复一些BUG（音乐不播放），简单优化界面；

2022/9/1：发布0.8.30版本
1、增加交易界面，交易命令game.trade；
2、完善角色属性状态显示；
3、至此，功能性的东西开发完毕，接下来就是常规修BUG、优化和可视化编程了。

2022/8/31：发布0.8.20版本
1、增加存档读档功能；
2、再次加强脚本系统（修复在脚本中执行clear，然后再次运行脚本的BUG）；
3、修改了一些BUG；

2022/8/26：发布0.8.19版本
1、增强 delfighthero 命令；
2、修复升级BUG和其他BUG；
3、增强 脚本系统（增加执行完毕保存返回值，且合并了fight.msg、fight.run和fight.script）；
4、优化战斗运行卡顿问题（缓存）；

2022/8/19：发布0.8.16版本
1、增强 getskill、removeskill 命令，删除 removeskillname 命令；
2、修复几个小bug；

2022/8/14：发布0.8.15版本
1、完善群体性攻击；

2022/8/10：发布0.8.14版本
1、新增game.heros、game.roles、game.delhero、delallheros指令；
2、优化存储坐标代码、其他部分；

2022/8/9：发布0.8.13版本
1、增加角色影子设置；
2、修复选择框BUG；
3、修复创建工程BUG；
4、修复异步脚本执行器的一个大BUG（真悬呐），多亏了荔枝；

2022/8/8：发布0.8.12版本
1、调整game.msg、game.say、fight.msg；
2、完善战斗选人功能；
3、逃跑有几率；
4、修复几个BUG和一个内存泄露；

2022/8/5：发布0.8.11版本
1、修复一个bug；
2、增加道具买卖钱数；

2022/8/4：发布0.8.10版本
1、增加装备脱下；
2、可以显示道具和装备的描述；
3、增加role的状态为静止；
4、完善了一些细节东西；

2022/8/3：发布0.8.9版本
修改几个BUG；

2022/8/2：发布0.8.8版本
1、增加3个命令：goods、hasgoods、equipment；
2、调整usegoods命令；
3、加入出现警告、错误等信息时自动弹出提示框；
4、增加剪切板功能；
5、修改几个BUG；

2022/7/30：发布0.8.7版本
1、改了几个命令；
2、完善了道具背包系统；
3、完善了存档功能；
4、地图编辑器加入了测试功能；
5、下一步：修改战斗编辑器和战斗角色编辑器；

2022/5/29：发布0.8.6版本
1、写了个Bug；
2、把上面的Bug修复了；

2022/5/22：发布0.8.5版本
1、完成道具和装备系统；到此为止开发基本完毕了，剩下就是美化和完善细节；
2、优化、修复。。;

2022/4/27：发布0.8.4版本
1、优化脚本引擎；修复引擎Bug；
2、战斗引擎中加入 fight 属性指令集，可以调用相关命令；
3、加入升级和升级链算法脚本；
4、新增每秒恢复事件算法脚本；
5、整整3个月左右了，得休息一阵子了。。。

2022/4/26：发布0.8.3版本
1、重写战斗动画执行脚本引擎；
2、完善了同步脚本引擎内容，以后基本不会变化了；

2022/4/25：发布0.8.2版本
1、完善战斗动画效果：加入文字动态显示；
2、增强脚本和逻辑功能；
3、完善战斗算法、技能算法功能；
4、增强血条显示；
5、新增game.getskill、game.removeskill命令；

2022/4/23：发布0.8.1版本
重大更新：历时几天，终于把运行外部js系统做出来了，还支持脚本错误准确提示。
1、新增game.runjs、game.script、game.evaluate、game.evaluateFile、game.importModule命令；
2、增强脚本系统（支持从文件运行）；

2022/4/23：发布0.7.10版本
1、完善战斗动画效果：加入多特效混用；

2022/4/22：发布0.7.9版本
1、完善战斗动画效果：加入特效；

2022/4/21：发布0.7.8版本
1、完善战斗动画效果和血条；
2、特效中加入镜像和缩放功能；
3、修复同步脚本框架的Bug；
4、修复音乐Bug；

2022/4/20：发布0.7.7版本
1、完善技能编辑和功能；
2、继续完善战斗特效；
3、优化代码；

2022/4/19：发布0.7.6版本
1、加入存档校验；
2、继续完善了战斗脚本、效果和指令；
3、修复Bug；

2022/4/18：发布0.7.5版本
1、做了很多战斗系统方面的东西；
2、修复了一些小Bug；

2022/4/17：发布0.7.4版本
1、初步完善战斗编辑系统，继续细化完善；
2、准备升级链和道具系统；
3、准备生成项目系统；
4、修复PC端打包乱码错误（编码问题）；
5、可以使用示例项目了（点击后请等待完成）；

2022/4/16：发布0.7.3版本
1、完善了项目工程管理；
2、完善了解包功能；
继续做战斗；

2022/4/12：发布0.7.2版本
1、绘制地图加入复制粘贴功能（长按复制）；
2、增加地图编辑器的铺图功能（将地图块图片铺到地图层上）；
3、优化体验；
4、修复同步代码小框架的BUG；
5、修复两个比较恶心的BUG（又踩了QML的坑）；
可以专心作战斗画面了~

2022/4/11：发布0.7.1版本
1、重大更新：目前脚本支持同步代码（异步执行）了，我自己做了个同步执行代码小框架，且支持嵌套调用，支持函数、字符串创建；
2、优化 game.say 和 game.msg 效果；
3、新增 game.wait 命令；

2022/4/9：发布0.6.3版本
1、修复BUG；
2、加入战斗系统（测试）和game.fight、game.fighton、game.fightoff指令；

2022/4/7：发布0.6.2版本
1、优化脚本编辑器；
2、加入game.rnd随机数脚本命令；

2022/4/5：发布0.6.1版本
1、加入特效编辑器；
2、加入game.say脚本命令；
3、将方向优化为0.1以下的偏移为停止主角移动；
4、地图编辑器在绘制地图时，单击地图会显示坐标；
5、修复BUG；优化代码；优化界面和操作。。。

2022/4/2：发布0.6.0版本
1、加固底层代码，加入安卓的Java（dex）代码热更新，目前已完全实现个平台的热更新功能（包括安卓的so、dex，win的dll，资源文件，底层代码，Maker层QML代码和游戏层QML代码）；
2、修复部分BUG，优化部分代码；

2022/3/31：发布0.3.6版本
1、继续优化代码；
2、微调界面；
3、修复安卓选择文件真实路径BUG；

2022/3/30：发布0.3.5版本
1、大幅优化核心代码；

2022/3/29：发布0.3.4版本
1、将小地图居中到屏幕；
2、修正一些BUG，优化代码；

2022/3/28：发布0.3.3版本
1、增加游戏工程导入导出功能；
2、准备导出APK相关工作；
3、地图事件可以删除；
4、调整游戏刷新率、计时器精度（之前非常不精确）；
5、调整角色的速度单位为 像素/毫秒，这样不同刷新率下角色移动速度相同；
6、修正角色碰撞会滑步BUG；

2022/3/28：发布0.3.2版本
1、修复载入地图白屏BUG（这次真的修复了）；
2、优化载入地图时屏乱BUG；
3、修复事件保存的严重BUG；
4、修复其他N多BUG；

2022/3/27：发布0.3.1版本
1、加入了区分地图前景和背景（目前0层和1层地图自动为背景，其他均为前景）；
2、修正NPC移动概率（任何刷新率下概率差不多）；
3、支持修改地图大小、地图块大小；
4、修复资源路径问题；
5、修复跨平台编码问题；
6、修复若干Bug；

2022/3/26：发布0.3.0版本
1、修好了地图编辑器第一次进入白屏的问题；
2、加入了素材功能（选择图片会复制到项目目录下）；
3、地图编辑器的操作修正（单击绘制、双击清除）；
4、修改了项目目录结构；
5、支持地图块图片替换和大小修改（替换图块功能）；
6、优化了多指触摸按键；
7、加入了方向遥感速度；

2022/3/23：发布0.2.0版本

`
        msgBox.text = GlobalLibraryJS.convertToHTML(t);
    }
}
