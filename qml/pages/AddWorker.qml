import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../Workers.js" as WR

Page {
    id: addWorkerPage

    SilicaFlickable{
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

        VerticalScrollDecorator {}

        Column {
            id: column
            width: parent.width

            PageHeader { title: "Добавление сотрудника" }

            TextField {
                id: surname
                width: parent.width
                label: "Фамилия"
                placeholderText: "Введите фамилию"
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: name.focus = true
            }

            TextField {
                id: name
                width: parent.width
                label: "Имя"
                placeholderText: "Введите имя"
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: patronymic.focus = true
            }

            TextField {
                id: patronymic
                width: parent.width
                label: "Отчество"
                placeholderText: "Введите отчество"
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: age.focus = true
            }

            TextField {
                id: age
                width: parent.width
                label: "Возраст"
                placeholderText: "Введите возраст"
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: education.focus = true
            }

            TextField {
                id: education
                width: parent.width
                label: "Образование"
                placeholderText: "Введите образование"
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: position.focus = true
            }

            TextField {
                id: position
                width: parent.width
                label: "Должность"
                placeholderText: "Введите должность"
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: departmentName.focus = true
            }

            TextField {
                id: departmentName
                width: parent.width
                label: "Отдел"
                placeholderText: "Введите название отдела"
                EnterKey.onClicked: { addNewWorker() }
            }

            TextField {
                id: errorMessage
                width: parent.width
                readOnly: true
                color: "red"
                text: ''
                visible: true
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Добавить"
                onClicked: addNewWorker()
            }
        }
    }

    function addNewWorker() {
        if (surname.text === '' || name.text === '' || patronymic.text === '' || age.text === ''
                || education.text === '' || position.text === '' || departmentName.text === '') {
            errorMessage.text = 'Заполните все поля';
        } else {
            errorMessage.visible = '';
            WR.dbInsert(surname.text, name.text, patronymic.text, age.text,
                        education.text, position.text, departmentName.text);
        }
    }
}
