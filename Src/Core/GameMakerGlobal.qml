pragma Singleton

import QtQuick 2.14
import Qt.labs.settings 1.1


import _Global 1.0


import 'qrc:/QML'


import 'GameMakerGlobal.js' as GameMakerGlobalJS



QtObject {

    //可存储配置
    //  目前存储：Projects/工程名（game.cd引擎变量，用到了$PauseMusic、$PauseSound）、$RunTimes、$RunDuration
    property Settings settings: Settings {
        id: settings
        category: 'GameMaker'    //类别
        //fileName: 'GameMaker.ini'
        //fileName: parseInt(FrameManager.sl_configValue('RunType')) === 0 ? '' : 'GameMaker.ini'

        //当前工程
        property string $strCurrentProjectName: ''  //'Project'
        property int $RunTimes: 0
        property int $RunDuration: 0
    }



    property string separator: Platform.sl_separator(true)

    property url urlGameMakerCorePath: Qt.resolvedUrl('.')


    //引擎版本
    property string version: '1.15.1.250101'


    //配置
    property QtObject config: QtObject {
        //调试（显示一些调试功能）
        //property bool debug: Global.frameConfig.$sys.debug === 0 ? false : true
        //property bool debug: parseInt(FrameManager.config.Debug) === 0 ? false : true
        //property bool debug: parseInt(FrameManager.sl_configValue('Debug', 0)) === 0 ? false : true
        property bool debug: true


        //当前项目名称
        property alias strCurrentProjectName: settings.$strCurrentProjectName    //'Project'

        //引擎工作目录
        property string strWorkPath: {
            switch(Qt.platform.os) {
            case 'android':
                return Platform.externalDataPath + separator + 'GameMaker';
                //return 'assets:';   //'.'  //':'
            case 'windows':
                if(Platform.compileType === 'release')
                    return 'GameMaker';
                else
                    return 'F:/_Projects/Pets/MakerFrame/GameMaker';
            default:
                return 'GameMaker';
                //return '.';
            }
        }

        //项目根目录
        property string strProjectRootPath: {
            return strWorkPath + separator + 'Projects';
        }

        //存档目录
        property string strSaveDataPath: {
            switch(Qt.platform.os) {
            case 'android':
                return strWorkPath + separator + 'SaveData' + separator + strCurrentProjectName;
                //return Platform.externalDataPath + separator + 'Games' + separator + strCurrentProjectName + separator + 'SaveData';
                //return Platform.sl_getSdcardPath() + separator + 'Leamus' + separator + 'Games' + separator + strCurrentProjectName + separator + 'SaveData';
            case 'windows':
            default:
                return strWorkPath + separator + 'SaveData' + separator + strCurrentProjectName;
                //return 'SaveData';
            }
        }


        //数据文件存储 目录名
        property string strMapDirName: 'Maps'
        property string strRoleDirName: 'Roles'
        property string strSpriteDirName: 'Sprites'
        property string strGoodsDirName: 'Goods'
        property string strFightRoleDirName: 'FightRoles'
        property string strFightSkillDirName: 'FightSkills'
        property string strFightScriptDirName: 'FightScripts'

        //资源 目录名
        property string strResourceDirName: 'Resources'
        property string strMapResourceDirName: strResourceDirName + separator + 'Maps'
        property string strSpriteResourceDirName: strResourceDirName + separator + 'Sprites'
        property string strGoodsResourceDirName: strResourceDirName + separator + 'Goods'
        property string strImageResourceDirName: strResourceDirName + separator + 'Images'
        property string strMusicResourceDirName: strResourceDirName + separator + 'Music'
        property string strSoundResourceDirName: strResourceDirName + separator + 'Sounds'
        property string strVideoResourceDirName: strResourceDirName + separator + 'Videos'

        //!!!兼容旧代码!!!
        property string strRoleResourceDirName: strResourceDirName + separator + 'Sprites'
    }


    //TapTap 开发者中心对应 ClientID和ClientToken，为空表示不使用tap验证
    //readonly property string tds_ClientID: ''
    //readonly property string tds_ClientToken: ''



    //下面函数是返回 某类型资源 的绝对路径（参数都是可选）

    property var mapResourceURL: filepath=>GlobalJS.toURL(mapResourcePath(filepath))
    function mapResourcePath(filepath) {
        let ret = config.strProjectRootPath + separator + config.strCurrentProjectName + separator + config.strMapResourceDirName;
        if(filepath)
            return ret + separator + filepath;
        return ret;
    }
    property var spriteResourceURL: filepath=>GlobalJS.toURL(spriteResourcePath(filepath))
    function spriteResourcePath(filepath) {
        let ret = config.strProjectRootPath + separator + config.strCurrentProjectName + separator + config.strSpriteResourceDirName;
        if(filepath)
            return ret + separator + filepath;
        return ret;
    }
    property var goodsResourceURL: filepath=>GlobalJS.toURL(goodsResourcePath(filepath))
    function goodsResourcePath(filepath) {
        let ret = config.strProjectRootPath + separator + config.strCurrentProjectName + separator + config.strGoodsResourceDirName;
        if(filepath)
            return ret + separator + filepath;
        return ret;
    }


    property var soundResourceURL: filepath=>GlobalJS.toURL(soundResourcePath(filepath))
    function soundResourcePath(filepath='') {
        // /开始的目录，则相对于项目根路径
        if(filepath.indexOf('/') === 0)
            return config.strProjectRootPath + separator + config.strCurrentProjectName + filepath;
        //绝对目录
        else if(filepath.indexOf(':') >= 0)
            return GlobalJS.toPath(filepath);
        //相对目录
        else {
            let ret = config.strProjectRootPath + separator + config.strCurrentProjectName + separator + config.strSoundResourceDirName;
            if(filepath)
                return ret + separator + filepath;
            return ret;
        }
    }

    property var musicResourceURL: filepath=>GlobalJS.toURL(musicResourcePath(filepath))
    function musicResourcePath(filepath='') {
        // /开始的目录，则相对于项目根路径
        if(filepath.indexOf('/') === 0)
            return config.strProjectRootPath + separator + config.strCurrentProjectName + filepath;
        //绝对目录
        else if(filepath.indexOf(':') >= 0)
            return GlobalJS.toPath(filepath);
        //相对目录
        else {
            let ret = config.strProjectRootPath + separator + config.strCurrentProjectName + separator + config.strMusicResourceDirName;
            if(filepath)
                return ret + separator + filepath;
            return ret;
        }
    }

    property var imageResourceURL: filepath=>GlobalJS.toURL(imageResourcePath(filepath))
    function imageResourcePath(filepath='') {
        // /开始的目录，则相对于项目根路径
        if(filepath.indexOf('/') === 0)
            return config.strProjectRootPath + separator + config.strCurrentProjectName + filepath;
        //绝对目录
        else if(filepath.indexOf(':') >= 0)
            return GlobalJS.toPath(filepath);
        //相对目录
        else {
            let ret = config.strProjectRootPath + separator + config.strCurrentProjectName + separator + config.strImageResourceDirName;
            if(filepath)
                return ret + separator + filepath;
            return ret;
        }
    }

    property var videoResourceURL: filepath=>GlobalJS.toURL(videoResourcePath(filepath))
    function videoResourcePath(filepath='') {
        // /开始的目录，则相对于项目根路径
        if(filepath.indexOf('/') === 0)
            return config.strProjectRootPath + separator + config.strCurrentProjectName + filepath;
        //绝对目录
        else if(filepath.indexOf(':') >= 0)
            return GlobalJS.toPath(filepath);
        //相对目录
        else {
            let ret = config.strProjectRootPath + separator + config.strCurrentProjectName + separator + config.strVideoResourceDirName;
            if(filepath)
                return ret + separator + filepath;
            return ret;
        }
    }

    //!!!兼容旧代码!!!
    property var roleResourceURL: filepath=>GlobalJS.toURL(roleResourcePath(filepath))
    function roleResourcePath(filepath) {
        let ret = config.strProjectRootPath + separator + config.strCurrentProjectName + separator + config.strRoleResourceDirName;
        if(filepath)
            return ret + separator + filepath;
        return ret;
    }



    //使用时长
    property Timer timer: Timer {
        //id: timer

        property var nLastTime: new Date().getTime()

        repeat: true
        interval: 6000
        triggeredOnStart: false
        running: true
        onRunningChanged: {
            //if(running === true)
            //    nLastTime = new Date().getTime();
        }

        onTriggered: {
            let now = new Date().getTime();
            settings.$RunDuration += parseInt((now - nLastTime) / 1000);
            nLastTime = now;
        }
    }



    Component.onCompleted: {
        //!!解决 assets BUG
        if(Qt.platform.os === 'android' && Qt.resolvedUrl('.').indexOf('file:assets:/') === 0)
            return;

        if(FrameManager.sl_globalObject().GameMakerGlobal && FrameManager.sl_globalObject().GameMakerGlobal !== GameMakerGlobal) {
            console.warn('[!GameMakerGlobal]已经存在单例类，请重启框架或返回原引擎');

            Global.window.aliasGlobal.dialogCommon.show({
                Msg: '已经存在单例类，请重启框架或返回原引擎，否则数据出错',
                //Buttons: 0,
                OnAccepted: function() {
                },
                OnRejected: ()=>{
                },
            });
            return;
        }

        FrameManager.sl_globalObject().GameMakerGlobal = GameMakerGlobal;



        if(Platform.compileType === 'release') {
            let userID = '', account = '', nickname = '';
            if(Global.frameSettings.$userData) {
                let userData = JSON.parse(FrameManager.sl_uncompress(Global.frameSettings.$userData, 1).toString());
                userID = userData.info.id;
                account = userData.info.account;
                nickname = userData.info.nickname;
            }

            //提交访问信息
            GlobalLibraryJS.request({
                Url: 'http://MakerFrame.Leamus.cn/api/v1/client/usage',
                Method: 'POST',
                Data: {
                    client: `${Platform.sysInfo.prettyProductName}_${Platform.sysInfo.currentCpuArchitecture}(${Platform.compileType})`,
                    product: `${settings.category}_${Platform.sysInfo.buildCpuArchitecture}_${version}`,
                    serial: `${Platform.sysInfo.machineUniqueId}${Qt.platform.os==='android'?'_'+Platform.sl_getSerialNumber():''}`,
                    timestamp: Number(new Date()), UserID: userID, Account_: account, Nickname_: nickname,
                    times: settings.$RunTimes, duration: settings.$RunDuration,
                },
                //`client=${Platform.sysInfo.prettyProductName}_${Platform.sysInfo.currentCpuArchitecture}(${Platform.compileType})&product=${settings.category}_${Platform.sysInfo.buildCpuArchitecture}_${version}&serial=${Platform.sysInfo.machineUniqueId}${Qt.platform.os==='android'?'_'+Platform.sl_getSerialNumber():''}&timestamp=${Number(new Date())}&UserID=${userID}&Account_=${account}&Nickname_=${nickname}&times=${settings.$RunTimes}&duration=${settings.$RunDuration}`
                Gzip: [1, 1024],
                //Headers: {},
            }).$then((xhr)=>{
            }).$catch((xhr)=>{
            });
        }



        FrameManager.sl_addImportPath(urlGameMakerCorePath);



        console.debug('[GameMakerGlobal]Component.onCompleted:', GameMakerGlobal, GameMakerGlobalJS, Qt.resolvedUrl('.'));
    }
    Component.onDestruction: {
        //!!解决 assets BUG
        if(Qt.platform.os === 'android' && Qt.resolvedUrl('.').indexOf('file:assets:/') === 0)
            return;

        if(FrameManager.sl_globalObject().GameMakerGlobal && FrameManager.sl_globalObject().GameMakerGlobal !== GameMakerGlobal) {
            console.warn('[!GameMakerGlobal]已经存在单例类');
            return;
        }

        delete FrameManager.sl_globalObject().GameMakerGlobal;

        console.debug('[GameMakerGlobal]Component.onDestruction');
    }
}
