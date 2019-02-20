var db = LocalStorage.openDatabaseSync("Workers", "1.0", "Workers SQL Database");

//try {
//    db.transaction(function(tx){
//        tx.executeSql('CREATE TABLE IF NOT EXISTS Workers(ID, surname, name, patronymic, education, position, departmentName, companyName)');
//        console.log('Database initialized');
//    })
//} catch (err) {
//    console.log("Error creating table in database: " + err);
//}

//function dbGetHandle()
//{
//    try {
//        var db = LocalStorage.openDatabaseSync("Workers", "1.0", "Workers SQL Database");
//    } catch (err) {
//        console.log("Error opening database: " + err)
//    }
//    return db;
//}

//удаление работника по id
function removeWorker(ID) {
//    var db = dbGetHandle();
//    if (!db) initializeDB();

    db.transaction(function(tx) {
        tx.executeSql('DELETE FROM Workers WHERE ID = ?', [ID]);
    });
}

//добавление работника
function addWorker(surname, name, patronymic, education, position, departmentName, companyName) {
//    var db = dbGetHandle();
//    if (!db) initializeDB();

    db.transaction(function(tx) {
        tx.executeSql(
                    'INSERT INTO Workers VALUES(?, ?, ?, ?, ?, ?, ?, ?)',
                    [newID(), surname, name, patronymic, education, position, departmentName, companyName]
                    );
    });
}

//получить работника по id
function getWorkerById(ID) {
//    var db = dbGetHandle();
//    if (!db) initializeDB();

    var workers;
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM Workers WHERE ID = ?', [ID]);
        workers = rs.rows
    });
    return workers;
}

//получить список сотрудников, удовл. параметрам
function getWorkersByParams(params, callback) {
//    var db = dbGetHandle();
//    if (!db) initializeDB();

    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM Workers');
        var model = [];
        var rows = rs.rows;
        for(var i = 0; i < rows.length; i++)
            if(rows.item(i).surname === params.surname || params.surname === '') //surname
                if(rows.item(i).name === params.name || params.name === '') //name
                    if(rows.item(i).patronymic === params.patronymic || params.patronymic === '') //patronymic
                        if(rows.item(i).education === params.education || params.education === '') //education
                            if(rows.item(i).position === params.position || params.position === '') //position
                                if(rows.item(i).departmentName === params.departmentName || params.departmentName === '') //departmentName
                                    if(rows.item(i).companyName === params.companyName || params.companyName === '') //companyName
                                        model.push(rows.item(i));

        callback(model);
    });
}

//создание еще неиспользуемого id
function newID() {
    var idExist = true;
    var id = 0;
    while(idExist) {
        getWorkerById(id, function(rows) { idExist = (rows.length > 0) })
        id++;
    }
    return id.toString();
}

//получить список всех работиков
function getAllWorkers(callback) {
//    var db = dbGetHandle();
//    if (!db) initializeDB();

    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM Workers');
        var model = [];
        for (var i = 0; i < rs.rows.length; i++) {
            var row = rs.rows.item(i);
            model.push({
                           ID: row.ID,
                           surname: row.surname,
                           name: row.name,
                           patronymic: row.patronymic
                       })
        }
        callback(model);
    });
}

