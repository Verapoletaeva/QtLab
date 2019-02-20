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
            }

            TextField {
                id: name
                width: parent.width
                label: "Имя"
                placeholderText: "Введите имя"
            }

            TextField {
                id: patronymic
                width: parent.width
                label: "Отчество"
                placeholderText: "Введите отчество"
            }

            TextField {
                id: education
                width: parent.width
                label: "Образование"
                placeholderText: "Введите образование"
            }

            TextField {
                id: position
                width: parent.width
                label: "Должность"
                placeholderText: "Введите должность"
            }

            TextField {
                id: departmentName
                width: parent.width
                label: "Отдел"
                placeholderText: "Введите название отдела"
            }

            TextField {
                id: companyName
                width: parent.width
                label: "Компания"
                placeholderText: "Введите название компании"
            }

            Text {
                id: errorMessage
                width: parent.width
                color: "red"
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Добавить"
                onClicked: WR.dbInsert(surname.text, name.text, patronymic.text,
                                       education.text, position.text, departmentName.text, companyName.text)
            }
        }
    }

//    function addNewWorker() {
//        if(workerSurname.length === 0 || workerName.length === 0
//                || workerPatronymic.length === 0 || workerEducation.length === 0
//                || workerPosition.length === 0 || workerDepartmentName.length === 0 || workerCompanyName.length === 0){
//            errorMessage.text = 'Есть незаполненные обязательные поля!';
//            console.log("Не добавлен");
//        } else {
//            errorMessage.text = ''
//            WR.addWorker(workerSurname.text, workerName.text, workerPatronymic.text,
//                         workerEducation.text, workerPosition.text, workerDepartmentName.text, workerCompanyName.text);
//            console.log(workerSurname.text, workerName.text, workerPatronymic.text,
//                        workerEducation.text, workerPosition.text, workerDepartmentName.text, workerCompanyName.text);
//        }
//    }
}
