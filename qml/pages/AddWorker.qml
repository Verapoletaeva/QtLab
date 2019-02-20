import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../Workers.js" as WR

Page {
    id: addWorker

    SilicaFlickable{
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

        VerticalScrollDecorator {}

        Column {
            id: column
            width: parent.width

            PageHeader { title: qsTr("Добавление сотрудника") }

            TextArea {
                id: workerSurname;
                width: parent.width
                label: qsTr("Фамилия")
                placeholderText: qsTr("Введите фамилию")
            }

            TextArea {
                id: workerName
                width: parent.width
                label: qsTr("Имя")
                placeholderText: qsTr("Введите имя")
            }

            TextArea {
                id: workerPatronymic
                width: parent.width
                label: qsTr("Отчество")
                placeholderText: qsTr("Введите отчество")
            }

            TextArea {
                id: workerEducation
                width: parent.width
                label: qsTr("Образование")
                placeholderText: qsTr("Введите образование")
            }

            TextArea {
                id: workerPosition
                width: parent.width
                label: qsTr("Должность")
                placeholderText: qsTr("Введите должность")
            }

            TextArea {
                id: workerDepartmentName
                width: parent.width
                label: qsTr("Отдел")
                placeholderText: qsTr("Введите название отдела")
            }

            TextArea {
                id: workerCompanyName
                width: parent.width
                label: qsTr("Компания")
                placeholderText: qsTr("Введите название компании")
            }

            Text {
                id: errorMessage
                width: parent.width
                color: "red"
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Добавить")
                onClicked: addNewWorker()
            }
        }
    }

    function addNewWorker() {
        if(workerSurname.length === 0 || workerName.length === 0
                || workerPatronymic.length === 0 || workerEducation.length === 0
                || workerPosition.length === 0 || workerDepartmentName.length === 0 || workerCompanyName.length === 0){
            errorMessage.text = 'Есть незаполненные обязательные поля!';
            console.log("Не добавлен");
        } else {
            errorMessage.text = ''
            WR.addWorker(workerSurname.text, workerName.text, workerPatronymic.text,
                         workerEducation.text, workerPosition.text, workerDepartmentName.text, workerCompanyName.text);
            console.log(workerSurname.text, workerName.text, workerPatronymic.text,
                        workerEducation.text, workerPosition.text, workerDepartmentName.text, workerCompanyName.text);
        }
    }
}
