/****************************************************************************
**
** Copyright (C) 2013-2015 Oleg Yadrov
**
** Licensed under the Apache License, Version 2.0 (the "License");
** you may not use this file except in compliance with the License.
** You may obtain a copy of the License at
**
** http://www.apache.org/licenses/LICENSE-2.0
**
** Unless required by applicable law or agreed to in writing, software
** distributed under the License is distributed on an "AS IS" BASIS,
** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
** See the License for the specific language governing permissions and
** limitations under the License.
**
****************************************************************************/

import QtQuick 2.14
import QtQuick.Layouts 1.14
import QtQuick.Window 2.14


import _Global 1.0
import _Global.Button 1.0

import LGlobal 1.0



Item {
    id: root

//    property alias gameMenu: gameMenu
//    property alias rectGoods: rectGoods
//    property alias flickableGoods: flickableGoods
//    property alias gameGoodsMenu: gameGoodsMenu

    //
    signal s_close();

    //显示或关闭
    signal s_show(int newFlags, int windowFlags);
    signal s_hide(int newFlags, int windowFlags);


    //打开了哪些窗口
    property int nShowWindowFlags: 0


    function showWindow(flags=1, value=0, style={}) {
        //closeWindow();
        let newFlags = 0;

        if((flags & 0b1) && !(nShowWindowFlags & 0b1)) {
            maskMainMenu.color = style.MaskColor ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$main', '$maskColor') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$main', '$maskColor');
            gameMenu.border.color = style.BorderColor ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$main', '$borderColor') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$main', '$borderColor');
            gameMenu.color = style.BackgroundColor ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$main', '$backgroundColor') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$main', '$backgroundColor');
            gameMenu.nItemFontSize = style.ItemFontSize || style.FontSize ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$main', '$itemFontSize') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$main', '$itemFontSize');
            gameMenu.colorItemFontColor = style.ItemFontColor || style.FontColor ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$main', '$itemFontColor') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$main', '$itemFontColor');
            gameMenu.colorItemColor1 = style.ItemBackgroundColor1 || style.BackgroundColor ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$main', '$itemBackgroundColor1') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$main', '$itemBackgroundColor1');
            gameMenu.colorItemColor2 = style.ItemBackgroundColor2 || style.BackgroundColor ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$main', '$itemBackgroundColor2') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$main', '$itemBackgroundColor2');
            gameMenu.nTitleFontSize = style.TitleFontSize || style.FontSize ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$main', '$titleFontSize') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$main', '$titleFontSize');
            gameMenu.colorTitleColor = style.TitleBackgroundColor || style.BackgroundColor ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$main', '$titleBackgroundColor') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$main', '$titleBackgroundColor');
            gameMenu.colorTitleFontColor = style.TitleFontColor || style.BackgroundColor ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$main', '$titleFontColor') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$main', '$titleFontColor');
            gameMenu.colorItemBorderColor = style.ItemBorderColor || style.BorderColor ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$main', '$itemBorderColor') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$main', '$itemBorderColor');
            gameMenu.strTitle = style.TitleText ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$main', '$titleText') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$main', '$titleText');

            mainMenu.visible = true;

            nShowWindowFlags |= 0b1;
            newFlags |= 0b1;
        }
        if((flags & 0b10) && !(nShowWindowFlags & 0b10)) {
            itemFightRoleInfo.maskFightRoleInfo.color = style.MaskColor || '#7FFFFFFF';
            itemFightRoleInfo.init(value || 0);
            itemFightRoleInfo.visible = true;
            //showFightRoleInfo(value || 0);

            nShowWindowFlags |= 0b10;
            newFlags |= 0b10;
        }
        if((flags & 0b100) && !(nShowWindowFlags & 0b100)) {
            rectGoods.maskGoods.color = style.MaskColor || '#7FFFFFFF';
            rectGoods.init();
            //rectGoods.showGoods(-1);
            rectGoods.visible = true;

            nShowWindowFlags |= 0b100;
            newFlags |= 0b100;
        }
        if((flags & 0b1000) && !(nShowWindowFlags & 0b1000)) {
            containerSystemMenu.maskSystemMenu.color = style.MaskColor ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$system', '$maskColor') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$system', '$maskColor');
            containerSystemMenu.gamemenuSystemMenu.border.color = style.BorderColor ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$system', '$borderColor') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$system', '$borderColor');
            containerSystemMenu.gamemenuSystemMenu.color = style.BackgroundColor ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$system', '$backgroundColor') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$system', '$backgroundColor');
            containerSystemMenu.gamemenuSystemMenu.nItemFontSize = style.ItemFontSize || style.FontSize ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$system', '$itemFontSize') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$system', '$itemFontSize');
            containerSystemMenu.gamemenuSystemMenu.colorItemFontColor = style.ItemFontColor || style.FontColor ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$system', '$itemFontColor') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$system', '$itemFontColor');
            containerSystemMenu.gamemenuSystemMenu.colorItemColor1 = style.ItemBackgroundColor1 || style.BackgroundColor ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$system', '$itemBackgroundColor1') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$system', '$itemBackgroundColor1');
            containerSystemMenu.gamemenuSystemMenu.colorItemColor2 = style.ItemBackgroundColor2 || style.BackgroundColor ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$system', '$itemBackgroundColor2') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$system', '$itemBackgroundColor2');
            containerSystemMenu.gamemenuSystemMenu.nTitleFontSize = style.TitleFontSize || style.FontSize ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$system', '$titleFontSize') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$system', '$titleFontSize');
            containerSystemMenu.gamemenuSystemMenu.colorTitleColor = style.TitleBackgroundColor || style.BackgroundColor ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$system', '$titleBackgroundColor') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$system', '$titleBackgroundColor');
            containerSystemMenu.gamemenuSystemMenu.colorTitleFontColor = style.TitleFontColor || style.BackgroundColor ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$system', '$titleFontColor') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$system', '$titleFontColor');
            containerSystemMenu.gamemenuSystemMenu.colorItemBorderColor = style.ItemBorderColor || style.BorderColor ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$system', '$itemBorderColor') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$system', '$itemBorderColor');
            containerSystemMenu.gamemenuSystemMenu.strTitle = style.TitleText ||
                    GlobalLibraryJS.getObjectValue(game, '$userscripts', '$config', '$window', '$system', '$titleText') ||
                    GlobalLibraryJS.getObjectValue(game, '$gameMakerGlobalJS', '$config', '$window', '$system', '$titleText');

            containerSystemMenu.showSystemMenu();

            nShowWindowFlags |= 0b1000;
            newFlags |= 0b1000;
        }


        if(nShowWindowFlags !== 0)
            visible = true;


        s_show(newFlags, nShowWindowFlags);
    }

    function closeWindow(flags=-1) {

        let newFlags = 0;

        if((flags & 0b1) && (nShowWindowFlags & 0b1)) {
            mainMenu.visible = false;
            nShowWindowFlags &= ~0b1;
            newFlags |= 0b1;
        }
        if((flags & 0b10) && (nShowWindowFlags & 0b10)) {
            itemFightRoleInfo.visible = false;
            nShowWindowFlags &= ~0b10;
            newFlags |= 0b10;
        }
        if((flags & 0b100) && (nShowWindowFlags & 0b100)) {
            rectGoods.visible = false;
            nShowWindowFlags &= ~0b100;
            newFlags |= 0b100;
        }
        if((flags & 0b1000) && (nShowWindowFlags & 0b1000)) {
            containerSystemMenu.visible = false;
            nShowWindowFlags &= ~0b1000;
            newFlags |= 0b1000;
        }


        //rectStatus.visible = false;
        //rectSkills.visible = false;
        //rectEquipment.visible = false;
        //itemUseOrEquip.visible = false;
        //rectEquipInfo.visible = false;


        if(nShowWindowFlags === 0) {
            visible = false;
            s_close();
        }


        s_hide(newFlags, nShowWindowFlags);
    }


    /*function showFightRoleInfo(nIndex) {
        itemFightRoleInfo.init(nIndex);
    }*/



    //主菜单
    Item {
        id: mainMenu

        anchors.fill: parent
        visible: false


        Mask {
            id: maskMainMenu

            anchors.fill: parent
            color: "#7FFFFFFF"

            mouseArea.onPressed: {
                closeWindow(0b1);
            }
        }


        ColumnLayout {
            id: gameMainMenu

            width: parent.width * 0.6
            //width: Screen.width > Screen.height ? parent.width * 0.6 : parent.width * 0.96
            //height: parent.height * 0.5
            height: Math.min(gameMenu.implicitHeight, parent.height * 0.6)

            anchors.centerIn: parent

            spacing: 0

            //菜单
            GameMenu {
                id: gameMenu
                Layout.fillHeight: true
                Layout.fillWidth: true

                border.color: "white"
                radius: height / 20

                onS_Choice: function(index) {

                    switch(index) {
                    case 0:
                        root.showWindow(0b10);
                        //itemFightRoleInfo.init();
                        break;
                    case 1:
                        root.showWindow(0b100);
                        //rectGoods.init();
                        break;
                    case 2:
                        root.showWindow(0b1000);
                        //containerSystemMenu.showSystemMenu();
                        break;
                    default:
                        closeWindow(-1);
                    }
                }
            }
        }

    }



    GameBagWindow {
        id: rectGoods

        //铺满整个屏幕
        anchors.fill: parent
        visible: false

    }


    GameFightHeroInfoWindow {
        id: itemFightRoleInfo

        anchors.fill: parent
        visible: false
    }


    GameSystemWindow {
        id: containerSystemMenu

        anchors.fill: parent
        visible: false
    }


    /*/选择道具
    Item {
        id: itemUseOrEquip

        property int choiceIndex: -1


        anchors.fill: parent
        visible: false


        Mask {
            anchors.fill: parent
            color: "lightgray"
            opacity: 0.6

            mouseArea.onPressed: {
                itemUseOrEquip.visible = false;
            }
        }


        Column {

            width: parent.width * 0.6
            height: parent.height * 0.5
            anchors.centerIn: parent

            spacing: 10


            Rectangle {

                width: parent.width
                height: textGoodsInfo.implicitHeight

                color: "darkblue"

                Text {
                    id: textGoodsInfo
                    anchors.fill: parent

                    color: "white"

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    font.pointSize: 16
                    font.bold: true
                    text: ""
                    wrapMode: Text.Wrap
                }
            }

            ColorButton {
                id: buttonUse

                width: parent.width

                text: "使用"
                onButtonClicked: {
                    _private.close();


                    let goods = game.gd["$sys_goods"][itemUseOrEquip.choiceIndex];
                    game.usegoods(goods.$rid);
                }
            }
            ColorButton {
                id: buttonEquip

                width: parent.width

                text: "装备"
                onButtonClicked: {
                    _private.close();


                    let goods = game.gd["$sys_goods"][itemUseOrEquip.choiceIndex];
                    let goodsInfo = game.objGoods[goods.$rid];

                    if(goodsInfo.$commons.$equipScript)
                        game.run(goodsInfo.$commons.$equipScript(goods, goodsInfo));
                        //game.run(goodsInfo.$commons.$equipScript(goods.$rid));
                }
            }
        }

    }
    */




    /*/状态框
    Rectangle {
        id: rectStatus
        anchors.centerIn: parent
        width: parent.width * 0.6
        height: parent.height * 0.5
        color: "lightgray"
        visible: false

        Column {
            anchors.fill: parent

            Text {
                id: textHP
                text: qsTr("")
            }
            Text {
                id: textMP
                text: qsTr("")
            }
            Text {
                id: textAttack
                text: qsTr("")
            }
            Text {
                id: textDefense
                text: qsTr("")
            }
            Text {
                id: textPower
                text: qsTr("")
            }
            Text {
                id: textLuck
                text: qsTr("")
            }
            Text {
                id: textSpeed
                text: qsTr("")
            }
            Text {
                id: textEXP
                text: qsTr("")
            }
            Text {
                id: textLevel
                text: qsTr("")
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked:
                rectStatus.visible = false
        }
    }


    //装备框
    Item {
        id: rectEquipment
        anchors.centerIn: parent
        width: parent.width * 0.6
        height: parent.height * 0.5
        //color: "lightgray"
        visible: false

        GameMenu {
            id: gameEquipmentMenu
            width: parent.width
            //implicitHeight很大时会滚动，implicitHeight很小时会按顺序排列
            //height: flickableEquipment.height < implicitHeight ? flickableEquipment.height : implicitHeight
            height: parent.height
            //nItemMaxHeight: 100
            //nItemMinHeight: 50

            onS_Choice: function(index) {
                switch(index) {
                case 0:
                    break;
                case 1:
                    break;
                case 2:
                    break;
                case 3:
                    break;
                default:
                    //root.visible = false;
                }

                rectEquipInfo.choicePosition = index;

                let hero = game.gd["$sys_fight_heros"][0];
                let position = rectEquipInfo.positions[rectEquipInfo.choicePosition];
                textEquipInfo.text = game.objGoods[hero.$equipment[position].$rid].$description;

                rectEquipInfo.visible = true;
            }
        }
    }


    //技能框
    Item {
        id: rectSkills
        anchors.centerIn: parent

        width: parent.width * 0.6
        height: parent.height * 0.5

        //color: "lightgray"

        visible: false

        GameMenu {
            id: gameSkillsMenu
            width: parent.width
            //implicitHeight很大时会滚动，implicitHeight很小时会按顺序排列
            //height: flickableSkills.height < implicitHeight ? flickableSkills.height : implicitHeight
            height: parent.height
            //nItemMaxHeight: 100
            //nItemMinHeight: 50

            onS_Choice: function(index) {
                switch(index) {
                case 0:
                    break;
                case 1:
                    break;
                case 2:
                    break;
                case 3:
                    break;
                default:
                    //root.visible = false;
                }
            }
        }
    }

    */


    /*/选择装备
    Rectangle {
        id: rectEquipInfo
        anchors.centerIn: parent
        width: parent.width * 0.6
        height: parent.height * 0.5
        color: "lightgray"
        visible: false

        property int choicePosition
        property var positions: []

        Column {
            anchors.fill: parent

            TextEdit {
                id: textEquipInfo

                width: parent.width
                wrapMode: TextEdit.Wrap
            }

            ColorButton {
                id: buttonUnload

                width: parent.width

                text: "脱下"
                onButtonClicked: {
                    _private.close();


                    //let hero = game.gd["$sys_fight_heros"][0];
                    game.getgoods(game.unload(0, rectEquipInfo.positions[rectEquipInfo.choicePosition]));
                }
            }
        }

    }
    */





    QtObject {  //私有数据,函数,对象等
        id: _private


        /*/显示技能
        function showSkills(heroIndex=0) {
            if(game.gd["$sys_fight_heros"].length <= heroIndex) {
                return;
            }

            let hero = game.gd["$sys_fight_heros"][heroIndex];
            let arrName = [];
            for(let skill of hero["skills"]) {
                arrName.push(skill.$name);
            }

            //for(let i = 0; i < 2; ++i)
            //    arrName.push(i + 'hi');

            rectSkills.visible = true;
            gameSkillsMenu.show(arrName);
        }

        function showEquipment(heroIndex=0) {

            if(game.gd["$sys_fight_heros"].length <= heroIndex) {
                rectEquipment.visible = true;
                return;
            }

            rectEquipInfo.positions = [];
            let arrEquipment = [];
            let hero = game.gd["$sys_fight_heros"][heroIndex];
            for(let position in hero.$equipment) {
                rectEquipInfo.positions.push(position);
                arrEquipment.push('%1：%2'.arg(position).arg(game.objGoods[hero.$equipment[position].$rid].$properties.name) );
                //textEquipment.text = textEquipment.text + equipment + "  " + game.objGoods[hero.$equipment[position].$rid].$properties.name + "\r\n";
            }

            //for(let i = 0; i < 2; ++i)
            //    arrName.push(i + 'hi');

            gameEquipmentMenu.show(arrEquipment);

            rectEquipment.visible = true;
        }

        function showStatus(heroIndex=0) {

            if(game.gd["$sys_fight_heros"].length <= heroIndex) {
                textHP.text = "没有这个战斗角色";
                rectStatus.visible = true;
                return;
            }

            let hero = game.gd["$sys_fight_heros"][heroIndex];

            textHP.text = "HP：" + hero.$$propertiesWithExtra.remainHP + "/" + hero.$$propertiesWithExtra.healthHP + "/" + hero.$$propertiesWithExtra.HP;
            textMP.text = "MP："+ hero.$$propertiesWithExtra.remainMP + "/" + hero.$$propertiesWithExtra.MP;
            textAttack.text = "攻击：" + hero.$$propertiesWithExtra.attack;
            textDefense.text = "防御：" + hero.$$propertiesWithExtra.defense;
            textPower.text = "灵力：" + hero.$$propertiesWithExtra.power;
            textLuck.text = "幸运：" + hero.$$propertiesWithExtra.luck;
            textSpeed.text = "速度：" + hero.$$propertiesWithExtra.speed;
            textEXP.text = "经验：" + hero.$properties.EXP;
            textLevel.text = "级别：" + hero.$properties.level;

            rectStatus.visible = true;
        }
        */

    }

    Component.onCompleted: {
        gameMenu.show(["状态", "背包", "系统", "关闭菜单"]);
    }
}