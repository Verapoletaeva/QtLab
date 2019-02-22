import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../Workers.js" as WR

Page {
    property var workers: []
    property bool all: false
    property bool exist: true

    id: workersPage

    ListModel { id: workerList }

    SilicaListView {
        id: listView
        anchors.fill: parent
        width: parent.width
        model: workerList

        header: PageHeader { title: qsTr("Сотрудники") }
        onVisibleChanged: {
            workerList.clear();

            if(all)
                workers = WR.dbGetAll();

            if (workers.length === 0) {
                exist = false;
                workerList.append({ID: 1024, surname: 'Сотрудников не найдено', name: '', patronymic: ''});
            } else {
                exist = true;
            }

            for (var i = 0; i < workers.length; i++) {
                workerList.append(workers[i]);
            }
        }

        delegate: BackgroundItem {
            width: listView.width

            Label {
                color: highlighted ? Theme.highlightColor : Theme.primaryColor
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.horizontalPageMargin
                text: model.ID.toString() + ' ' + model.surname + ' ' + firstLetter(model.name)
                      + firstLetter(model.patronymic)
            }

            onClicked: {
                if (exist) {
                    console.log(typeof model.ID, model.ID);
                    pageStack.push(Qt.resolvedUrl("WorkerInfo.qml"), {workerId: model.ID});
                }
            }
        }
    }

    function firstLetter(str) {
        if (str.length)
            return str[0] + '.';
        return '';
    }
}

