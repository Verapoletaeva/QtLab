function dbInit() {
    var db = LocalStorage.openDatabaseSync("Workers", "", "Workers SQL Database", 1000000);

    try {
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS Workers(Id numeric, surname text, name text, patronymic text, age text, education text, position text, departmentName text)');
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

function dbInsert(surname, name, patronymic, age, education, position, departmentName) {
    var db = dbGetHandle();
    var rowid = 0;
    db.transaction(function(tx) {
        tx.executeSql('INSERT INTO Workers VALUES(?,?,?,?,?,?,?,?)',
                      [newId(), surname, name, patronymic, age, education, position, departmentName]);
        var result = tx.executeSql('SELECT last_insert_rowid()');
        rowid = result.insertId;
    });

    console.log('Новый пользователь!');
}

function dbGetAll() {
    var db = dbGetHandle();
    var model = [];
    db.transaction(function(tx) {
        var result = tx.executeSql('SELECT * FROM Workers ORDER BY Id');

        for (var i = 0; i < result.rows.length; i++) {
            var item = result.rows.item(i);
            model.push({
                           ID: item.Id,
                           surname: item.surname,
                           name: item.name,
                           patronymic: item.patronymic,
                           age: item.age,
                           education: item.education,
                           position: item.position,
                           departmentName: item.departmentName
                       })
            console.log(model[i].name);
        }
    });
    return model;
}

function dbRemoveRow(id) {
    var db = dbGetHandle();
    db.transaction(function(tx) {
        tx.executeSql('DELETE FROM Workers WHERE Id = ?', [id]);
    })
}

function dbGetById(id) {
    var db = dbGetHandle();
    var model = [];
    var result;
    db.transaction(function(tx) {
        result = tx.executeSql('SELECT * FROM Workers WHERE Id = ?', [id]);
    });
    if (result.rows.length > 0) {
        var item = result.rows.item(0);
        return ({
                    ID: item.Id,
                    surname: item.surname,
                    name: item.name,
                    patronymic: item.patronymic,
                    age: item.age,
                    education: item.education,
                    position: item.position,
                    departmentName: item.departmentName
                });
    }
}

function dbHasId(id) {
    var db = dbGetHandle();
    var hasId = false;
    db.transaction(function(tx) {
        var result = tx.executeSql('SELECT * FROM Workers WHERE Id = ?', [id]);
        if (result.rows.length > 0)
            hasId = true;
    });
    return hasId;
}

function newId() {
    var db = dbGetHandle();
    var result;
    var id = 1;
    var exist = true;
    db.transaction(function(tx) {
        result = tx.executeSql('SELECT Id FROM Workers ORDER BY Id');
    });

    while (exist) {
        exist = false;
        for (var i = 0; i < result.rows.length; i++) {
            if (result.rows.item(i).Id === id) {
                exist = true;
                id++;
                break;
            }
        }
    }

    return id;
}

function dbGetByParams(surname, name, patronymic, education, position, departmentName) {
    var workers = dbGetAll();
    var res = [];
    for (var i = 0; i < workers.length; i++) {
        var item = workers[i];
        if (item.surname.indexOf(surname) >= 0 && item.name.indexOf(name) >= 0
                && item.patronymic.indexOf(patronymic) >= 0 && item.education.indexOf(education) >= 0
                 && item.position.indexOf(position) >= 0 && item.departmentName.indexOf(departmentName) >= 0)
            res.push(item);
    }
    return res;
}

