import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.14
import QtQuick.Dialogs 1.2 as Dialog1
import QtQuick.Layouts 1.14
import QtGraphicalEffects 1.0
import QtMultimedia 5.14
import Qt.labs.settings 1.1


//引入Qt定义的类
import cn.Leamus.MakerFrame 1.0


import _Global 1.0
import _Global.Button 1.0

//import LGlobal 1.0


import "qrc:/QML"


//import "GameMakerGlobal.js" as GameMakerGlobalJS

//import "GameScene.js" as GameSceneJS
//import "File.js" as File




//游戏视窗，组件位置和大小固定
Item {
    id: rootItemViewPort


    //打开地图
    function openMap(mapPath) {

        itemBackMapContainer.visible = false;
        itemFrontMapContainer.visible = false;

        //let cfg = File.read(mapPath);
        let mapInfo = FrameManager.sl_qml_ReadFile(Global.toPath(mapPath + GameMakerGlobal.separator + "map.json"));
        //console.debug("cfg", cfg, mapPath);

        if(mapInfo === "")
            return false;
        mapInfo = JSON.parse(mapInfo);
        //console.debug("cfg", cfg);
        //loader.setSource("./MapEditor_1.qml", {});


        //地图数据
        //itemContainer.mapInfo = JSON.parse(File.read(mapFilePath));
        itemContainer.mapInfo = mapInfo;

        let nMapBlockScale = parseFloat(itemContainer.mapInfo.MapScale) || 1;
        sizeMapBlockSize.width = Math.round(itemContainer.mapInfo.MapBlockSize[0] * nMapBlockScale);
        sizeMapBlockSize.height = Math.round(itemContainer.mapInfo.MapBlockSize[1] * nMapBlockScale);

        itemContainer.width = itemContainer.mapInfo.MapSize[0] * sizeMapBlockSize.width;
        itemContainer.height = itemContainer.mapInfo.MapSize[1] * sizeMapBlockSize.height;

        //如果地图小于等于场景，则将地图居中
        if(itemContainer.width < gameScene.width)
            itemContainer.x = parseInt((width - itemContainer.width * gameScene.scale) / 2 / gameScene.scale);
        if(itemContainer.height < gameScene.height)
            itemContainer.y = parseInt((height - itemContainer.height * gameScene.scale) / 2 / gameScene.scale);

        //console.debug("!!!", itemContainer.width, gameScene.scale, width, itemContainer.x);
        //console.debug("!!!", itemContainer.height, gameScene.scale, height, itemContainer.y);


        //卸载原地图块图片
        for(let tc in itemBackMapContainer.arrCanvas) {
            itemBackMapContainer.arrCanvas[tc].unloadImage(imageMapBlock.source);
        }
        for(let tc in itemFrontMapContainer.arrCanvas) {
            itemFrontMapContainer.arrCanvas[tc].unloadImage(imageMapBlock.source);
        }

        imageMapBlock.source = GlobalJS.toURL(GameMakerGlobal.mapResourceURL(itemContainer.mapInfo.MapBlockImage[0]));

        //载入新地图块图片
        for(let tc in itemBackMapContainer.arrCanvas) {
            itemBackMapContainer.arrCanvas[tc].loadImage(imageMapBlock.source);
            if(itemBackMapContainer.arrCanvas[tc].isImageLoaded(imageMapBlock.source)) {
                //console.debug("[GameMapView]Canvas.loadImage载入OK，requestPaint");
                itemBackMapContainer.arrCanvas[tc].requestPaint();
            }
            //else
                //console.debug("[GameMapView]Canvas.loadImage载入NO，等待回调。。。");
        }
        for(let tc in itemFrontMapContainer.arrCanvas) {
            itemFrontMapContainer.arrCanvas[tc].loadImage(imageMapBlock.source);
            if(itemFrontMapContainer.arrCanvas[tc].isImageLoaded(imageMapBlock.source)) {
                //console.debug("[GameMapView]canvasBackMap.loadImage载入OK，requestPaint");
                itemFrontMapContainer.arrCanvas[tc].requestPaint();
            }
            //else
                //console.debug("[GameMapView]Canvas.loadImage载入NO，等待回调。。。");
        }


        itemContainer.mapEventBlocks = {};
        //转换事件的地图块的坐标为地图块的ID
        for(let i in itemContainer.mapInfo.MapEventData) {
            let p = i.split(',');
            itemContainer.mapEventBlocks[parseInt(p[0]) + parseInt(p[1]) * itemContainer.mapInfo.MapSize[0]] = itemContainer.mapInfo.MapEventData[i];
        }

        //console.debug("itemContainer.mapEventBlocks", JSON.stringify(itemContainer.mapEventBlocks))

        return true;
    }

    //释放
    function release() {

        itemContainer.mapInfo = null;

        for(let tc in itemBackMapContainer.arrCanvas) {
            itemBackMapContainer.arrCanvas[tc].unloadImage(imageMapBlock.source);
            GlobalLibraryJS.Utils.clearCanvas(itemBackMapContainer.arrCanvas[tc]);
            itemBackMapContainer.arrCanvas[tc].requestPaint();
        }
        for(let tc in itemFrontMapContainer.arrCanvas) {
            itemFrontMapContainer.arrCanvas[tc].unloadImage(imageMapBlock.source);
            GlobalLibraryJS.Utils.clearCanvas(itemFrontMapContainer.arrCanvas[tc]);
            itemFrontMapContainer.arrCanvas[tc].requestPaint();
        }

        //canvasBackMap.unloadImage(imageMapBlock.source);
        //canvasFrontMap.unloadImage(imageMapBlock.source);
        imageMapBlock.source = "";

    }

    //块坐标对应的真实坐标
    //bx、by为块坐标；dx、dy为偏移坐标（为小数则偏移多少个块，为整数则偏移多少坐标）
    function getMapBlockPos(bx, by, dx=0.5, dy=0.5) {

        //边界检测

        if(bx < 0)
            bx = 0;
        else if(bx >= itemContainer.mapInfo.MapSize[0])
            bx = itemContainer.mapInfo.MapSize[0] - 1;

        if(by < 0)
            by = 0;
        else if(by >= itemContainer.mapInfo.MapSize[1])
            by = itemContainer.mapInfo.MapSize[1] - 1;


        //在目标图块最中央的 地图的坐标
        let targetX;
        let targetY;
        if(dx.toString().indexOf('.') < 0)
            targetX = parseInt((bx) * sizeMapBlockSize.width);
        else {
            targetX = parseInt((bx + dx) * sizeMapBlockSize.width);
            dx = 0;
        }
        if(dy.toString().indexOf('.') < 0)
            targetY = parseInt((by) * sizeMapBlockSize.height);
        else {
            targetY = parseInt((by + dy) * sizeMapBlockSize.height);
            dy = 0;
        }
        //let targetX = role.x + role.x1 + parseInt(role.width1 / 2);
        //let targetY = role.y + role.y1 + parseInt(role.height1 / 2);

        return [targetX + dx, targetY + dy];
    }

    //移动场景中心到地图的x、y
    function setScenePos(x, y) {
        //场景在地图左上角时的中央坐标
        let mapLeftTopCenterX = parseInt(gameScene.nMaxMoveWidth / 2);
        let mapLeftTopCenterY = parseInt(gameScene.nMaxMoveHeight / 2);

        //场景在地图右下角时的中央坐标
        let mapRightBottomCenterX = itemContainer.width - mapLeftTopCenterX;
        let mapRightBottomCenterY = itemContainer.height - mapLeftTopCenterY;

        //如果场景小于地图
        if(gameScene.width < itemContainer.width) {
            //如果人物中心 X 小于 地图左上坐标的 X
            if(x <= mapLeftTopCenterX) {
                itemContainer.x = 0;
            }
            //如果人物中心 X 大于 地图右下坐标的 X
            else if(x >= mapRightBottomCenterX) {
                itemContainer.x = gameScene.width - itemContainer.width;
            }
            //如果在区间，则随着主角移动
            else {
                itemContainer.x = mapLeftTopCenterX - x;
            }
        }
        //如果地图小于等于场景，则将地图居中
        else {
            itemContainer.x = parseInt((width - itemContainer.width * gameScene.scale) / 2 / gameScene.scale);

            //itemContainer.x = 0;
        }


        //如果场景小于地图
        if(gameScene.height < itemContainer.height) {
            //如果人物中心 Y 小于 地图左上坐标的 Y
            if(y <= mapLeftTopCenterY) {
                itemContainer.y = 0;
            }
            //如果人物中心 Y 大于 地图右下坐标的 Y
            else if(y >= mapRightBottomCenterY) {
                itemContainer.y = gameScene.height - itemContainer.height;
            }
            //如果在区间，则随着主角移动
            else {
                itemContainer.y = mapLeftTopCenterY - y;
            }
        }
        //如果地图小于等于场景，则将地图居中
        else {
            itemContainer.y = parseInt((height - itemContainer.height * gameScene.scale) / 2 / gameScene.scale);

            //itemContainer.y = 0;
        }
    }


    //计算 占用的图块
    function fComputeUseBlocks(x1, y1, x2, y2) {

        //let blocks = [];    //人物所占用地图块 列表

        //人物所占 起始和终止 的地图块ID，然后按序统计出来地图块
        ////+1、-1 是因为 小于等于图块 时，只占用1个图块
        let xBlock1 = Math.floor((x1) / sizeMapBlockSize.width);
        let xBlock2 = Math.floor((x2) / sizeMapBlockSize.width);
        let yBlock1 = Math.floor((y1) / sizeMapBlockSize.height);
        let yBlock2 = Math.floor((y2) / sizeMapBlockSize.height);

        /*/计算 所占的 地图块
        for(; yBlock1 <= yBlock2; ++yBlock1) {
            for(let xb = xBlock1; xb <= xBlock2; xb ++) {
                blocks.push(xb + yBlock1 * itemContainer.mapInfo.MapSize[0])
            }
        }
        return blocks;*/

        return [xBlock1, yBlock1, xBlock2, yBlock2];
    }


    //地图块大小（用于缩放地图块）
    property size sizeMapBlockSize

    //前景地图遮挡人物透明度
    property real rMapOpacity: 1

    property alias gameScene: gameScene
    property alias itemContainer: itemContainer

    property alias itemRoleContainer: itemRoleContainer
    property alias itemBackMapContainer: itemBackMapContainer
    property alias itemFrontMapContainer: itemFrontMapContainer
    property alias canvasBackMap: canvasBackMap
    property alias canvasFrontMap: canvasFrontMap

    property alias mouseArea: mouseArea


    //anchors.fill: parent
    //anchors.centerIn: parent
    width: parent.width
    height: parent.height

    clip: true


    //游戏场景(可视区域）
    Item {
        id: gameScene


        //场景的 人物的最大X、Y坐标（返回场景 / 地图 的较小值）；这个可以固定
        //如果地图小于场景时，人物不会到达场景边缘
        readonly property int nMaxMoveWidth: gameScene.width < itemContainer.width ? gameScene.width : itemContainer.width;
        readonly property int nMaxMoveHeight: gameScene.height < itemContainer.height ? gameScene.height : itemContainer.height;

        //地图场景的 最中央坐标（左上角的）；
        //人物绘制在场景最中间（返回地图最中间 - 人物的一半）
        ////readonly property int nRoleCenterInScenePosX: parseInt((gameScene.width - mainRole.width1) / 2);
        ////readonly property int nRoleCenterInScenePosY: parseInt((gameScene.height - mainRole.height1) / 2);



        //anchors.fill: parent
        // 除以scale的效果是：这个组件的实际大小其实是不变的，但它的子组件都会缩放，否则它自身也会缩放
        // 缩放后，这个组件的坐标系也会缩放
        width: parent.width / scale
        height: parent.height / scale
        //z: 0

        clip: true
        //缩放中心
        transformOrigin: Item.TopLeft
        //transformOrigin: Item.Center


        //color: "black"



        //所有东西的容器（大小为地图大小）
        Item {
            id: itemContainer


            property var mapInfo: null          //地图数据（map.json）
            property var mapEventBlocks: ({})   //有事件的地图块ID（换算后的）

            //property var image1: "1.jpg"
            //property var image2: "2.png"


            //width: 800
            //height: 600



            //地图点击
            MouseArea {
                id: mouseArea

                anchors.fill: parent
                acceptedButtons: Qt.AllButtons  /*Qt.LeftButton | Qt.RightButton*/
                //onClicked: {
                //    GameSceneJS.mapClickEvent(mouse.x, mouse.y);
                //}
            }



            Image { //预先载入图片
                id: imageMapBlock
                //source: "file:./1.png"
                visible: false

                onStatusChanged: {
                    /*if(status === Image.Ready) {
                        for(let tc in itemBackMapContainer.arrCanvas) {
                            itemBackMapContainer.arrCanvas[tc].requestPaint();
                        }
                        for(let tc in itemFrontMapContainer.arrCanvas) {
                            itemFrontMapContainer.arrCanvas[tc].requestPaint();
                        }

                        console.debug("[GameMapView]Image.Ready");
                    }
                    */
                }
                Component.onCompleted: {
                    console.debug("[GameMapView]Image Component.onCompleted");
                }
            }


            //背景地图容器
            Item {
                id: itemBackMapContainer
                anchors.fill: parent
                property var arrCanvas: [canvasBackMap]

                Canvas {
                    id: canvasBackMap

                    anchors.fill: parent

                    smooth: GlobalLibraryJS.shortCircuit(0b1, GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$map', '$smooth'), GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$map', '$smooth'), true)


                    onPaint: {  //绘制地图

                        //地图块没有准备好
                        /*if(imageMapBlock.status !== Image.Ready) {
                            console.debug("[GameMapView]canvasMapBlock：地图块图片没有准备好：", imageMapBlock.source.status);
                            return;
                        }*/

                        if(!available) {
                            console.debug("[GameMapView]canvasBackMap：地图块没有准备好：");
                            return;
                        }
                        if(!isImageLoaded(imageMapBlock.source)) {
                            console.debug("[GameMapView]canvasBackMap：地图块图片没有载入：");
                            //loadImage(imageMapBlock.source);
                            return;
                        }


                        let ctx = getContext("2d");

                        //ctx.fillStyle = Qt.rgba(1, 0, 0, 1);
                        //ctx.fillRect(0, 0, width, height);
                        ctx.clearRect(0, 0, width, height);

                        //循环绘制地图块
                        /* 之前的
                        for(let i = 0; i < itemContainer.mapInfo.data.length; i++)
                        {
                            //x1、y1为源，x2、y2为目标
                            let x1 = itemContainer.mapInfo.data[i] % itemContainer.mapInfo.MapSize[0];    //12
                            let y1 = parseInt(itemContainer.mapInfo.data[i] / itemContainer.mapInfo.MapSize[0]);  //16
                            let x2 = i % itemContainer.mapInfo.MapSize[0];  //12
                            let y2 = parseInt(i / itemContainer.mapInfo.MapSize[0]);    //16

                            ctx.drawImage(imageMapBlock.source,
                                          x1 * itemContainer.mapInfo.MapBlockSize[0], y1 * itemContainer.mapInfo.MapBlockSize[1],
                                          itemContainer.mapInfo.MapBlockSize[0], itemContainer.mapInfo.MapBlockSize[1],
                                          x2 * sizeMapBlockSize.width, y2 * sizeMapBlockSize.height,
                                          sizeMapBlockSize.width, sizeMapBlockSize.height);

                            //ctx.drawImage(imageMapBlock2.source, 0, 0, 100, 100);

                            if(y2 > itemContainer.mapInfo.MapSize[1]) {
                                console.warn("WARNING!!!too many rows");
                                break;
                            }
                        }
                        */

                        //绘制每一层
                        for(let k = 0; k < itemContainer.mapInfo.MapCount; ++k) {
                            //console.debug("k:", k);

                            //如果前景色需要半透明，则背景的每一层都必须绘制，如果没有半透明，则不需要绘制不属于地板层的
                            if(rMapOpacity >= 1)
                                //跳过不属于地板层的
                                if(k >= itemContainer.mapInfo.MapOfRole)
                                    continue;

                            for(let j = 0; j < itemContainer.mapInfo.MapData[k].length; ++j) {
                            //	console.debug("j:", j);
                                //循环绘制地图块
                                for(let i = 0; i < itemContainer.mapInfo.MapData[k][j].length; ++i) {
                            //		console.debug("i:", i);

                                    ctx.fillStyle = Qt.rgba(255, 0, 0, 1);
                                    //ctx.fillRect(x2, y2, sizeMapBlockSize.width, sizeMapBlockSize.height);

                                    if(itemContainer.mapInfo.MapData[k][j][i].toString() === '-1,-1,-1')
                                        continue;

                                    let _block = itemContainer.mapInfo.MapData[k][j][i];
                                    //x1、y1为源，x2、y2为目标
                                    let x1 = _block[0] * itemContainer.mapInfo.MapBlockSize[0];
                                    let y1 = _block[1] * itemContainer.mapInfo.MapBlockSize[1];
                                    let x2 = i * sizeMapBlockSize.width;
                                    let y2 = j * sizeMapBlockSize.height;

                                    //console.debug(k,j,i, ":", x1,y1,x2,y2);
                                    //console.debug(itemContainer.mapInfo.MapBlockSize[0], itemContainer.mapInfo.MapBlockSize[1], imageMapBlock, imageMapBlock.source);

                                    ctx.drawImage(imageMapBlock.source,
                                                  x1, y1,
                                                  itemContainer.mapInfo.MapBlockSize[0], itemContainer.mapInfo.MapBlockSize[1],
                                                  x2, y2,
                                                  sizeMapBlockSize.width, sizeMapBlockSize.height
                                    );
                                }
                            }
                        }

                        itemBackMapContainer.visible = true;

                        console.debug("[GameMapView]canvasMapBack onPaint");
                    }

                    onImageLoaded: {    //载入图片完成
                        requestPaint(); //重新绘图

                        console.debug("[GameMapView]canvasMapBack onImageLoaded");
                    }


                    Component.onCompleted: {
                        //loadImage(image1);  //载入图片
                        //loadImage(image2);
                        console.debug("[GameMapView]canvasMapBack Component.onCompleted");
                    }
                }
            }


            //精灵容器
            Item {
                id: itemRoleContainer
                anchors.fill: parent


                /*Role {
                    id: mainRole

                    property Message message: Message {
                        parent: mainRole
                        visible: false
                        width: parent.width
                        height: parent.height * 0.2
                        anchors.bottom: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter

                        nMaxHeight: 32

                        onS_over: {
                            visible = false;
                        }
                    }

                    property string $name: ""

                    //其他属性（用户自定义）
                    property var props: ({})



                    z: y + y1



                    Component.onCompleted: {
                        //console.debug("[GameMapView]Role Component.onCompleted");
                    }
                }
                */

            }


            //前景地图容器
            Item {
                id: itemFrontMapContainer
                anchors.fill: parent
                property var arrCanvas: [canvasFrontMap]

                Canvas {
                    id: canvasFrontMap

                    anchors.fill: parent

                    smooth: GlobalLibraryJS.shortCircuit(0b1, GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$map', '$smooth'), GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$map', '$smooth'), true)

                    opacity: rMapOpacity


                    onPaint: {  //绘制地图

                        //地图块没有准备好
                        /*if(imageMapBlock.status !== Image.Ready) {
                            console.debug("[GameMapView]canvasMapBlock：地图块图片没有准备好：", imageMapBlock.source.status);
                            return;
                        }*/

                        if(!available) {
                            console.debug("[GameMapView]canvasFrontMap：地图块没有准备好：");
                            return;
                        }
                        if(!isImageLoaded(imageMapBlock.source)) {
                            console.debug("[GameMapView]canvasFrontMap：地图块图片没有载入：");
                            //loadImage(imageMapBlock.source);
                            return;
                        }


                        let ctx = getContext("2d");

                        //ctx.fillStyle = Qt.rgba(1, 0, 0, 1);
                        //ctx.fillRect(0, 0, width, height);
                        ctx.clearRect(0, 0, width, height);

                        //循环绘制地图块
                        /* 之前的
                        for(let i = 0; i < itemContainer.mapInfo.data.length; i++)
                        {
                            //x1、y1为源，x2、y2为目标
                            let x1 = itemContainer.mapInfo.data[i] % itemContainer.mapInfo.MapSize[0];    //12
                            let y1 = parseInt(itemContainer.mapInfo.data[i] / itemContainer.mapInfo.MapSize[0]);  //16
                            let x2 = i % itemContainer.mapInfo.MapSize[0];  //12
                            let y2 = parseInt(i / itemContainer.mapInfo.MapSize[0]);    //16

                            ctx.drawImage(imageMapBlock.source,
                                          x1 * itemContainer.mapInfo.MapBlockSize[0], y1 * itemContainer.mapInfo.MapBlockSize[1],
                                          itemContainer.mapInfo.MapBlockSize[0], itemContainer.mapInfo.MapBlockSize[1],
                                          x2 * sizeMapBlockSize.width, y2 * sizeMapBlockSize.height,
                                          sizeMapBlockSize.width, sizeMapBlockSize.height);

                            //ctx.drawImage(imageMapBlock2.source, 0, 0, 100, 100);

                            if(y2 > itemContainer.mapInfo.MapSize[1]) {
                                console.warn("WARNING!!!too many rows");
                                break;
                            }
                        }
                        */

                        //绘制每一层
                        for(let k = 0; k < itemContainer.mapInfo.MapCount; ++k) {
                            //console.debug("k:", k);

                            //跳过地板层
                            if(k < itemContainer.mapInfo.MapOfRole)
                                continue;

                            for(let j = 0; j < itemContainer.mapInfo.MapData[k].length; ++j) {
                            //	console.debug("j:", j);
                                //循环绘制地图块
                                for(let i = 0; i < itemContainer.mapInfo.MapData[k][j].length; ++i) {
                            //		console.debug("i:", i);

                                    ctx.fillStyle = Qt.rgba(255, 0, 0, 1);
                                    //ctx.fillRect(x2, y2, sizeMapBlockSize.width, sizeMapBlockSize.height);

                                    if(itemContainer.mapInfo.MapData[k][j][i].toString() === '-1,-1,-1')
                                        continue;

                                    let _block = itemContainer.mapInfo.MapData[k][j][i];
                                    //x1、y1为源，x2、y2为目标
                                    let x1 = _block[0] * itemContainer.mapInfo.MapBlockSize[0];
                                    let y1 = _block[1] * itemContainer.mapInfo.MapBlockSize[1];
                                    let x2 = i * sizeMapBlockSize.width;
                                    let y2 = j * sizeMapBlockSize.height;

                                    //console.debug(k,j,i, ":", x1,y1,x2,y2);
                                    //console.debug(itemContainer.mapInfo.MapBlockSize[0], itemContainer.mapInfo.MapBlockSize[1], imageMapBlock, imageMapBlock.source);

                                    ctx.drawImage(imageMapBlock.source,
                                                  x1, y1,
                                                  itemContainer.mapInfo.MapBlockSize[0], itemContainer.mapInfo.MapBlockSize[1],
                                                  x2, y2,
                                                  sizeMapBlockSize.width, sizeMapBlockSize.height
                                    );
                                }
                            }
                        }

                        itemFrontMapContainer.visible = true;

                        console.debug("[GameMapView]canvasFrontMap onPaint");
                    }

                    onImageLoaded: {    //载入图片完成
                        requestPaint(); //重新绘图

                        console.debug("[GameMapView]canvasFrontMap onImageLoaded");
                    }


                    Component.onCompleted: {
                        //loadImage(image1);  //载入图片
                        //loadImage(image2);
                        console.debug("[GameMapView]canvasFrontMap Component.onCompleted");
                    }
                }
            }
        }
    }


    /*/游戏对话框
    Dialog {
        id: loaderGameMsg

        property alias textGameMsg: textGameMsg.text

        title: ""
        width: 300
        height: 200
        standardButtons: Dialog.Ok | Dialog.Cancel
        modal: true

        anchors.centerIn: parent

        Text {
            id: textGameMsg
            text: qsTr("")
        }


        MultiPointTouchArea {
            anchors.fill: parent
            enabled: loaderGameMsg.standardButtons === Dialog.NoButton
            onPressed: {
                //rootGameScene.forceActiveFocus();
                loaderGameMsg.reject();
            }
        }


        onAccepted: {
            //gameMap.focus = true;
            if(_private.config.bPauseGame)
                game.goon();
        }
        onRejected: {
            //gameMap.focus = true;
            if(_private.config.bPauseGame)
                game.goon();
            //console.log("Cancel clicked");
        }
    }*/
}

