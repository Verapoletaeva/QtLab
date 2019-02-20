import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../Workers.js" as WR

Page {
    property var workerId
    property var worker

    onVisibleChanged: {
        worker = WR.dbGetById(workerId);
    }

    ListModel {
        ListElement {
            title: surname
            value: worker.surname
        }
    }

//    SilicaListView {
//        delegate:
//    }
}
