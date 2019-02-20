import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../Workers.js" as WR

Page {
    id: searchWorkers

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

        VerticalScrollDecorator {}

        Column {
            id: column
            width: parent.width

            PageHeader { title: "Поиск сотрудника" }

            SectionHeader { text: "По ID" }

            TextField {
                id: workerID
                width: parent.width
                label: "ID"
                placeholderText: "ID сотрудника"
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                EnterKey.onClicked: pageStack.push(Qt.resolvedUrl('WorkerInfo.qml'),
                                                   {workerID: workerID})
            }

            Button {
                id: searchByIdBtn
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Найти")
                onClicked: pageStack.push(Qt.resolvedUrl('WorkerInfo.qml'), {workerID: workerID})
            }

            SectionHeader { text: "По параметрам" }

            TextField {
                id: workerSurname;
                width: parent.width
                label: qsTr("Фамилия")
                placeholderText: qsTr("Фамилия")
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: workerName.focus = true
            }

            TextField {
                id: workerName
                width: parent.width
                label: qsTr("Имя")
                placeholderText: qsTr("Имя")
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: workerPatronymic.focus = true
            }

            TextField {
                id: workerPatronymic
                width: parent.width
                label: qsTr("Отчество")
                placeholderText: qsTr("Отчество")
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: workerEducation.focus = true
            }

            TextField {
                id: workerEducation
                width: parent.width
                label: qsTr("Образование")
                placeholderText: qsTr("Образование")
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: workerPosition.focus = true
            }

            TextField {
                id: workerPosition
                width: parent.width
                label: qsTr("Должность")
                placeholderText: qsTr("Должность")
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: workerDepartmentName.focus = true
            }

            TextField {
                id: workerDepartmentName
                width: parent.width
                label: qsTr("Отдел")
                placeholderText: qsTr("Название отдела")
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: workerCompanyName.focus = true
            }

            TextField {
                id: workerCompanyName
                width: parent.width
                label: qsTr("Компания")
                placeholderText: qsTr("Название компании")
                onClicked: searchByParams()
            }

            Button {
                id: searchByParamsBtn
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Найти")
                onClicked: searchByParams()
            }
        }
    }

    function searchByParams() {
        //pageStack.push(Qt.resolvedUrl('Workers.qml'), {})
    }
}
