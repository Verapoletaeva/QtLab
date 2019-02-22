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
                EnterKey.onClicked: searchById()
            }

            TextField {
                id: errorMessage
                width: parent.width
                readOnly: true
                color: "red"
                text: 'Пользователя с таким ID не существует'
                visible: false
            }

            Button {
                id: searchByIdBtn
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Найти")
                onClicked: searchById()
            }

            SectionHeader { text: "По параметрам" }

            TextField {
                id: surname;
                width: parent.width
                label: qsTr("Фамилия")
                placeholderText: qsTr("Фамилия")
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: name.focus = true
            }

            TextField {
                id: name
                width: parent.width
                label: qsTr("Имя")
                placeholderText: qsTr("Имя")
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: patronymic.focus = true
            }

            TextField {
                id: patronymic
                width: parent.width
                label: qsTr("Отчество")
                placeholderText: qsTr("Отчество")
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: education.focus = true
            }

            TextField {
                id: education
                width: parent.width
                label: qsTr("Образование")
                placeholderText: qsTr("Образование")
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: position.focus = true
            }

            TextField {
                id: position
                width: parent.width
                label: qsTr("Должность")
                placeholderText: qsTr("Должность")
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: departmentName.focus = true
            }

            TextField {
                id: departmentName
                width: parent.width
                label: qsTr("Отдел")
                placeholderText: qsTr("Название отдела")
                EnterKey.onClicked: searchByParams()
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
        var workers = [];
        workers = WR.dbGetByParams(surname.text, name.text, patronymic.text,
                                   education.text, position.text, departmentName.text);

        pageStack.push(Qt.resolvedUrl('Workers.qml'), {workers: workers});
    }

    function searchById() {
        var id = Number(workerID.text);
        console.log(id, typeof id);

        if (WR.dbHasId(id)) {
            errorMessage.visible = false;
            workerID.text = '';
            pageStack.push(Qt.resolvedUrl('WorkerInfo.qml'), {workerId: id});
        } else {
            errorMessage.visible = true;
            console.log('Id not exist');
        }
    }
}
