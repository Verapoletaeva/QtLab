function dbInit() {
    var db = LocalStorage.openDatabaseSync("Workers", "", "Workers SQL Database", 1000000);

    try {
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS Workers(surname text, name text, patronymic text, education text, position text, departmentName text, companyName text)');
            console.log('Database initialized');
            //tx.executeSql('DROP TABLE Workers');
            //tx.executeSql('DELETE FROM Workers');
        })
    } catch (err) {
        console.log("Error creating table in database: " + err);
    };
}

function dbGetHandle() {
    try {
        var db = LocalStorage.openDatabaseSync("Workers", "", "Workers SQL Database", 1000000);
    } catch (err) {
        console.log("Error opening database: " + err);
    }

    return db;
}

function dbInsert(surname, name, patronymic, education, position, departmentName, companyName) {
    var db = dbGetHandle();
    var rowid = 0;
    db.transaction(function(tx) {
        tx.executeSql('INSERT INTO Workers VALUES(?,?,?,?,?,?,?)',
                      [surname, name, patronymic, education, position, departmentName, companyName]);
        var result = tx.executeSql('SELECT last_insert_rowid()');
        rowid = result.insertId;
    });
    console.log('Новый пользователь!');
}

function dbGetAll() {
    var db = dbGetHandle();
    var model = [];
    db.transaction(function(tx) {
        var result = tx.executeSql('SELECT rowid,surname,name,patronymic FROM Workers ORDER BY rowid');

        for (var i = 0; i < result.rows.length; i++) {
            model.push({
                           ID: result.rows.item(i).rowid,
                           surname: result.rows.item(i).surname,
                           name: result.rows.item(i).name,
                           patronymic: result.rows.item(i).patronymic
                       })
            console.log(model[i].name);
        }
    });
    return model;
}

function dbDeleteRow(id) {
    var db = dbGetHandle();
    db.transaction(function(tx) {
        tx.executeSql('DELETE FROM Workers WHERE rowid = ?', [id]);
    })
}

function dbGetById(id) {
    var db = dbGetHandle();
    var model = [];
    var result;
    db.transaction(function(tx) {
        result = tx.executeSql('SELECT * FROM Workers WHERE rowid = ?', [id]);
//        for (var i = 0; i < result.rows.length; i++) {
//            model.push({
//                           ID: result.rows.item(i).rowid,
//                           surname: result.rows.item(i).surname,
//                           name: result.rows.item(i).name,
//                           patronymic: result.rows.item(i).patronymic,
//                           education: result.rows.item(i).education,
//                           position: result.rows.item(i).position,
//                           departmentName: result.rows.item(i).departmentName,
//                           companyName: result.rows.item(i).companyName,

//                       })
//            console.log(model[i].name, model[i].surname);
//        }
    });
    return ({
                ID: result.rows.item(0).rowid,
                surname: result.rows.item(0).surname,
                name: result.rows.item(0).name,
                patronymic: result.rows.item(0).patronymic,
                education: result.rows.item(0).education,
                position: result.rows.item(0).position,
                departmentName: result.rows.item(0).departmentName,
                companyName: result.rows.item(0).companyName,

            });
}
