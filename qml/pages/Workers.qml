import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../Workers.js" as WR

Page {
    property var workers: []

    id: workersPage

    PageHeader { title: qsTr("Сотрудники") }

    SilicaListView {
        anchors.fill: parent
        width: parent.width
        model: workers

        delegate: BackgroundItem {
            width: parent.width
            onClicked: pageStack.push(Qt.resolvedUrl("WorkerInfo.qml"), {workerId: model.ID})

            Text {
                color: "black"
                anchors.centerIn: parent
                text: model.surname + " " + firstLetter(model.name) + "." + firstLetter(model.patronymic) + "."
            }
        }
    }
    function firstLetter(str) {
        if (str.length)
            return str[0];
    }
}

