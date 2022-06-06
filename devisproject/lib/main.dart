import 'package:flutter/material.dart';
import 'database_helper.dart';

void main() {
  runApp(MyApp());
}

// ----------------------- Página principal ------------------------------------

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Inicial()

    );
  }
}

class Inicial extends StatefulWidget {


  @override
  _InicialState createState() => _InicialState();
}

class _InicialState extends State<Inicial> {


  // TODO: Add text editing controllers (101)
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 30.0),
            Column(
              children: <Widget>[
                Image.asset('assets/logo1.png'),
                SizedBox(height: 10.0),
              ],
            ),
            SizedBox(height: 60.0),
             Text(
               textAlign: TextAlign.center,
              '¡No puede ser que aún no nos conozcamos!',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.red,
                fontSize: 17.0,
              ),
            ),
            SizedBox(height: 90.0),
            MaterialButton(
              minWidth: 200.0,
              height: 50.0,
              onPressed: () {
                Navigator.push(
                context,
                  MaterialPageRoute(builder: (context) => Inicial1()),
                  );
              },
              color: Colors.red,
              child: Text('Iniciar Sesión',style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 30.0),
            MaterialButton(
              minWidth: 200.0,
              height: 50.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Registre1()),
                );
              },
              color: Colors.red,
              child: Text('Registrarse', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------- Inici de sessió -------------------------------------

class Inicial1 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: LoginPage()

    );
  }
}

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  // TODO: Add text editing controllers (101)
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 50.0),
            Column(
              children: <Widget>[
                Image.asset('assets/logo1.png'),
                SizedBox(height: 10.0),
              ],
            ),
            SizedBox(height: 30.0),
            TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: 'E-mail',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Contraseña',
              ),
              obscureText: true,
            ),
            ButtonBar(
              children: <Widget>[
                ElevatedButton(
                  child: Text('Iniciar'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Conta1()),
                    );
                    },
                  ),
                ],
              ),
            Row(
              children: <Widget>[
                const Text('¿No tienes una cuenta?'),
                TextButton(
                  child: const Text(
                    'Regístrate',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Registre1()),
                      );
                    //signup screen
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------- Registrar-se ----------------------------------------

class Registre1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Registre()

    );
  }
}

class Registre extends StatefulWidget {

  @override
  _RegistreState createState() => _RegistreState();
}

class _RegistreState extends State<Registre> {
  final dbHelper = DatabaseHelper.instance;

  TextEditingController idController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contrasenyaController = TextEditingController();

  // TODO: Add text editing controllers (101)
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 30.0),
            Column(
              children: <Widget>[
                Image.asset('assets/logo1.png'),
                SizedBox(height: 10.0),
              ],
            ),
            SizedBox(height: 10.0),
            Container(
              child: TextField(
                controller: nombreController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Nombre',
                ),
              ),
            ),
            SizedBox(height: 12.0),
          Container(
            child: TextField(
              controller: apellidosController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Apellidos',
              ),
            ),
          ),
            SizedBox(height: 12.0),
          Container(
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'E-mail',
              ),
            ),
          ),
            SizedBox(height: 12.0),
            Container(
            child: TextField(
              controller: contrasenyaController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Contraseña',
              ),
              obscureText: true,
            ),
            ),
            ButtonBar(
              children: <Widget>[
                ElevatedButton(
                  child: Text('Registrarse'),
                  onPressed: () {
                      String nombre = nombreController.text;
                      String apellidos = apellidosController.text;
                      String email = emailController.text;
                      String contrasenya = contrasenyaController.text;
                      _insert(nombre,apellidos,email,contrasenya);
                      },
                    ),
                ElevatedButton(
                  child: Text('Query'),
                  onPressed: _query
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _insert(nombre,apellidos,email,contrasenya) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName  : nombre,
      DatabaseHelper.columnApellidos  : apellidos,
      DatabaseHelper.columnEmail  : email,
      DatabaseHelper.columnContrasenya  : contrasenya,
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach(print);
  }

}

// ----------------------- Pagina conta pers. ----------------------------------

class Conta1 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Conta()

    );
  }
}

class Conta extends StatefulWidget {


  @override
  _ContaState createState() => _ContaState();
}

class _ContaState extends State<Conta> {


  // TODO: Add text editing controllers (101)
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          children: <Widget>[
            SizedBox(height: 20.0),
            ButtonBar(
              children: <Widget>[
                ElevatedButton(
                  
                  child: Text('Cerrar Sessión'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 40.0),
            CircleAvatar(
                backgroundImage: AssetImage(
                    "assets/perfil1.jpg"),
                radius: 65.0),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text("Cillian Murphy",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text("ACTOR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 24.0, right: 24, top: 25, bottom: 24),
              child: Text(
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold
                ),
                "Sobre mí:",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 24.0, right: 24, top: 2, bottom: 24),
              child: Text(
                style: TextStyle(
                    fontSize: 15,
                ),
                  "Actor de cine, teatro y televisión irlandés. Empecé mi carrera artística como músico de rock.",
              ),
            ),
            SizedBox(height: 40.0),
            ButtonBar(
              children: <Widget>[
                ElevatedButton(
                  child: Text('Cambiar mi información'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Contrasenya1()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 1.0),
          ButtonBar(
          children: <Widget>[
            ElevatedButton(
              child: Text('     Eliminar mi cuenta     '),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Eliminar1()),
                );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------- Canviar info. --------------------------------

class Contrasenya1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Contrasenya()

    );
  }
}

class Contrasenya extends StatefulWidget {

  @override
  _ContrasenyaState createState() => _ContrasenyaState();
}

class _ContrasenyaState extends State<Contrasenya> {
  final dbHelper = DatabaseHelper.instance;

  TextEditingController idController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contrasenyaController = TextEditingController();

  // TODO: Add text editing controllers (101)
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 70.0),
            Container(
              child: TextField(
                controller: idController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Introduce tu ID',
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              child: TextField(
                controller: nombreController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Nuevo nombre',
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Container(
              child: TextField(
                controller: apellidosController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Nuevos Apellidos',
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Container(
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Nuevo E-mail',
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Container(
              child: TextField(
                controller: contrasenyaController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Nueva Contraseña',
                ),
                obscureText: true,
              ),
            ),
            ButtonBar(
              children: <Widget>[
                ElevatedButton(
                  child: Text('Actualizar'),
                  onPressed: () {
                    int id = int.parse(idController.text);
                    String nombre = nombreController.text;
                    String apellidos = apellidosController.text;
                    String email = emailController.text;
                    String contrasenya = contrasenyaController.text;
                    _update(id,nombre,apellidos,email,contrasenya);
                  },
                ),
                ElevatedButton(
                    child: Text('Query'),
                    onPressed: _query
                ),
                SizedBox(height: 20.0),
                Row(
                  children: <Widget>[
                    const Text('¿No quieres eliminar tu cuenta?'),
                    TextButton(
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Conta1()),
                        );
                        //signup screen
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                Row(
                  children: <Widget>[
                    const Text('¿No sabes cuál es tu ID de usuario?'),
                    TextButton(
                      child: const Text(
                        'Consultar',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _update(id, nombre, apellidos, email, contrasenya) async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.idUsuari  : id,
      DatabaseHelper.columnName  : nombre,
      DatabaseHelper.columnApellidos  : apellidos,
      DatabaseHelper.columnEmail  : email,
      DatabaseHelper.columnContrasenya  : contrasenya,
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach(print);
  }


}

// ----------------------- Eliminar conta --------------------------------------

class Eliminar1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Eliminar()

    );
  }
}

class Eliminar extends StatefulWidget {

  @override
  _EliminarState createState() => _EliminarState();
}

class _EliminarState extends State<Eliminar> {
  final dbHelper = DatabaseHelper.instance;

  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contrasenyaController = TextEditingController();
  TextEditingController idController = TextEditingController();

  // TODO: Add text editing controllers (101)
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          children: <Widget>[
            SizedBox(height: 30.0),
            Column(
              children: <Widget>[
                Image.asset('assets/logo1.png'),
                SizedBox(height: 10.0),
              ],
            ),
            SizedBox(height: 12.0),
            Container(
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Introduce tu ID de usuario',
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ButtonBar(
              children: <Widget>[
                ElevatedButton(
                  child: Text('Eliminar'),
                  onPressed: () {
                    int id = int.parse(idController.text);
                    _delete(id);
                  },
                ),
                ElevatedButton(
                  child: Text('Query'),
                  onPressed: _query
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const Text('¿No quieres eliminar tu cuenta?'),
                TextButton(
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Conta1()),
                    );
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Row(
              children: <Widget>[
                const Text('¿No sabes cuál es tu ID de usuario?'),
                TextButton(
                  child: const Text(
                    'Consultar',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }

  void _delete(id) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.delete(id);
  }
  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach(print);
  }

}

// ----------------------- Sapiguer ID -----------------------------------------
