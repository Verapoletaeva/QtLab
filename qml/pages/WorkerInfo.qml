import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../Workers.js" as WR

Page {
    property int workerId: 0

    id: workersInfoPage

    ListModel {
        id: infoModel
    }

    SilicaListView {
        id: listView
        anchors.fill: parent
        width: parent.width
        model: infoModel

        header: PageHeader { title: qsTr('Информация о сотруднике')}

        delegate: BackgroundItem {
            width: listView.width

            Label {
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.horizontalPageMargin
                text: qsTr(model.title + ': ' + model.name)
            }
        }
    }

    IconButton {
        icon.source: "image://theme/icon-l-clear"
        anchors {
            bottom: parent.bottom
            right: parent.right
            centerIn: parent.Center
            margins: 50
        }
        onClicked: { remove() }
    }


    TextField {
        id: message
        width: parent.width
        readOnly: true
        color: "red"
        text: 'Сотрудник удален!'
        visible: false
    }

    onVisibleChanged: { getInfo() }

    function getInfo() {
        if (workerId) {
            var worker = WR.dbGetById(workerId);

            infoModel.append({ title: 'ID', name: workerId.toString() });
            infoModel.append({ title: 'Фамилия', name: worker.surname });
            infoModel.append({ title: 'Имя', name: worker.name });
            infoModel.append({ title: 'Отчество', name: worker.patronymic });
            infoModel.append({ title: 'Возраст', name: worker.age });
            infoModel.append({ title: 'Образование', name: worker.education });
            infoModel.append({ title: 'Должность', name: worker.position });
            infoModel.append({ title: 'Отдел', name: worker.departmentName });
        }
        message.visible = false;
    }

    function remove() {
        listView.visible = false;
        WR.dbRemoveRow(workerId);
        message.visible = true;
    }
}
