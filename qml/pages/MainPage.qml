import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../Workers.js" as WR

Page {
    id: mainPage

    onVisibleChanged: dbInit()

    ListModel {
        id: pagesModel
        ListElement {
            title: 'Все сотрудники'
            page: 'All'
        }
        ListElement {
            title: 'Поиск по сотрудникам'
            page: 'SearchWorkers'

        }
        ListElement {
            title: 'Добавить сотрудника'
            page: 'AddWorker'
        }
    }

    SilicaListView {
        id: listView
        anchors.fill: parent
        model: pagesModel

        header: PageHeader { title: "Главная" }

        delegate: BackgroundItem {
            width: listView.width
            Label {
                text: model.title
                color: highlighted ? Theme.highlightColor : Theme.primaryColor
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.horizontalPageMargin
            }
            onClicked: {
                if (model.page === 'All')
                    showAll();
                else
                    pageStack.push(Qt.resolvedUrl(page + '.qml'));
            }
        }
        VerticalScrollDecorator {}
    }

    function showAll() {
        WR.getAllWorkers(function(rows) {
            pageStack.push(Qt.resolvedUrl('Workers.qml', { workers: rows }));
        })
    }

    function dbInit() {
//        WR.initializeDB();
    }
}
