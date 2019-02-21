import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../Workers.js" as WR

Page {
    property int workerId: 0
    property var worker: { ID: 0; surname: ''; name: ''; patronymic: '' }

    id: workersInfoPage

    ListModel {
        id: infoModel
        ListElement {
            title: qsTr('ID: ' + worker.ID)
        }
        ListElement {
            title: qsTr('Фамилия: ' + worker.surname)
        }
        ListElement {
            title: qsTr('Имя: ' + worker.surname)
        }
        ListElement {
            title: qsTr('Отчество: ' + worker.surname)
        }
        ListElement {
            title: qsTr('Образование: ' + worker.surname)
        }
        ListElement {
            title: qsTr('Должность: ' + worker.surname)
        }
        ListElement {
            title: qsTr('Отдел: ' + worker.surname)
        }
        ListElement {
            title: qsTr('Компания: ' + worker.surname)
        }
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
                text: model.title
            }
        }/*
        BackgroundItem {
            width: listView.width

            Label {
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.horizontalPageMargin
                text: qsTr('Фамилия: ' + worker.surname)
            }
        }
        BackgroundItem {
            width: listView.width

            Label {
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.horizontalPageMargin
                text: 'ID: ' + worker.name
            }
        }
        BackgroundItem {
            width: listView.width

            Label {
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.horizontalPageMargin
                text: 'ID: ' + worker.name
            }
        }
        BackgroundItem {
            width: listView.width

            Label {
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.horizontalPageMargin
                text: 'ID: ' + worker.name
            }
        }
        BackgroundItem {
            width: listView.width

            Label {
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.horizontalPageMargin
                text: 'ID: ' + worker.name
            }
        }
        BackgroundItem {
            width: listView.width

            Label {
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.horizontalPageMargin
                text: 'ID: ' + worker.name
            }
        }
        BackgroundItem {
            width: listView.width

            Label {
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.horizontalPageMargin
                text: 'ID: ' + worker.name
            }
        }*/
    }

    onVisibleChanged: { worker = WR.dbGetById(workerId); console.log(worker.name) }
}
