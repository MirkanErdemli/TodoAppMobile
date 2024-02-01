import 'package:flutter/material.dart';
import 'calendar_page.dart';
import 'information_page.dart';

class MyClass {
  String name;
  DateTime date;

  MyClass({required this.name, required this.date});
}

class User {
  String email;
  String password;
  String name;
  String surname;
  DateTime dateOfBirth;

  User({
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
    required this.dateOfBirth,
  });
}

class Subclass {
  String name;
  DateTime date;

  Subclass({required this.name, required this.date});
}

class Rectangle {
  String name;
  DateTime date;
  String className;

  Rectangle({required this.name, required this.date, required this.className});
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDate = DateTime.now();

  User yourUserInstance = User(
    name: 'Mirkan',
    surname: 'Erdemli',
    dateOfBirth: DateTime(2001, 6, 10),
    email: 'mr@gmail.com',
    password: '123456789',
  );

  List<MyClass> classList = [MyClass(name: 'All', date: DateTime.now())];
  List<Subclass> subclassList = [];
  List<Rectangle> rectangleList = [];
  double rectangleWidth = 360.0;
  String selectedClass = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _selectClass('All');
                  },
                  style: _getButtonStyle('All'),
                  child: Text('All'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showAddClassDialog();
                  },
                  child: Text('Add More Classes'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showDeleteClassesDialog();
                  },
                  child: Text('Delete Classes'),
                ),
              ],
            ),
            Wrap(
              spacing: 8.0,
              children: [
                ...classList
                    .where((myClass) =>
                        myClass.date.isBefore(selectedDate) ||
                        myClass.date.isAtSameMomentAs(selectedDate))
                    .map(
                      (myClass) => ElevatedButton(
                        onPressed: () {
                          _selectClass(myClass.name);
                        },
                        style: _getButtonStyle(myClass.name),
                        child: Text(myClass.name),
                      ),
                    ),
              ],
            ),
            Column(
              children: subclassList
                  .where((subclass) =>
                      subclass.date.isBefore(selectedDate) ||
                      subclass.date.isAtSameMomentAs(selectedDate))
                  .map(
                    (subclass) => _buildSubclass(subclass),
                  )
                  .toList(),
            ),
            Column(
              children: rectangleList
                  .where((rectangle) =>
                      (rectangle.date.isBefore(selectedDate) ||
                          rectangle.date.isAtSameMomentAs(selectedDate)) &&
                      (rectangle.className == selectedClass ||
                          selectedClass == 'All'))
                  .map(
                    (rectangle) => _buildRectangle(rectangle),
                  )
                  .toList(),
            ),
            Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddRectangleDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                _exitApp();
              },
              icon: Icon(Icons.exit_to_app, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                _showCalendarPage();
              },
              icon: Icon(Icons.calendar_today, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                _showInformationPage();
              },
              icon: Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubclass(Subclass subclass) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      width: rectangleWidth,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subclass.name,
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(width: 8.0),
          GestureDetector(
            onTap: () {
              setState(() {
                subclassList.remove(subclass);
              });
            },
            child: SquareButton(
              color: Colors.red,
              icon: Icons.close,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRectangle(Rectangle rectangle) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      width: rectangleWidth,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            rectangle.name,
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(width: 8.0),
          Row(
            children: [
              SquareButton(
                color: Colors.green,
                icon: Icons.check,
                onTap: () {
                  setState(() {
                    rectangleList.remove(rectangle);
                  });
                },
              ),
              SizedBox(width: 8.0),
              GestureDetector(
                onTap: () {
                  setState(() {
                    rectangleList.remove(rectangle);
                  });
                },
                child: SquareButton(
                  color: Colors.red,
                  icon: Icons.close,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _selectClass(String className) {
    setState(() {
      selectedClass = className;
    });
  }

  ButtonStyle _getButtonStyle(String className) {
    return ElevatedButton.styleFrom(
      primary: selectedClass == className ? Colors.green : null,
    );
  }

  void _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void _showAddClassDialog() {
    String newClassName = "";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Class'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) {
                  newClassName = value;
                },
                decoration: InputDecoration(labelText: 'Class Name'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _selectDate();
                },
                child: Text('Select Date'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newClassName.isNotEmpty) {
                  setState(() {
                    classList
                        .add(MyClass(name: newClassName, date: selectedDate));
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteClassesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Classes'),
          content: Column(
            children: [
              Text('Select classes to delete:'),
              SizedBox(height: 16.0),
              ...classList.map(
                (myClass) {
                  return CheckboxListTile(
                    title: Text(myClass.name),
                    value:
                        myClass.name != 'All' && myClass.name == selectedClass,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value != null) {
                          if (value) {
                            selectedClass = myClass.name;
                          } else {
                            selectedClass = 'All';
                          }
                        }
                      });
                    },
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  classList.removeWhere(
                    (myClass) => myClass.name == selectedClass,
                  );
                  rectangleList.removeWhere(
                    (rectangle) => rectangle.className == selectedClass,
                  );
                  selectedClass = 'All';
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showAddRectangleDialog() {
    String newRectangleName = "";
    String newRectangleClass = classList.first.name;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Rectangle'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) {
                  newRectangleName = value;
                },
                decoration: InputDecoration(labelText: 'Rectangle Name'),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: newRectangleClass,
                items: classList.map((MyClass myClass) {
                  return DropdownMenuItem<String>(
                    value: myClass.name,
                    child: Text(myClass.name),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    newRectangleClass = value!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newRectangleName.isNotEmpty) {
                  setState(() {
                    rectangleList.add(
                      Rectangle(
                        name: newRectangleName,
                        date: selectedDate,
                        className: newRectangleClass,
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showCalendarPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CalendarPage()),
    );
  }

  void _showInformationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InformationPage(loggedInUser: yourUserInstance),
      ),
    );
  }

  void _exitApp() {
    Navigator.pop(context);
  }
}

class SquareButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback? onTap;

  const SquareButton(
      {Key? key, required this.color, required this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        onPressed: onTap,
      ),
    );
  }
}
