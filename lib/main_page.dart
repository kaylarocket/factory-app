import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_gauge.dart';

//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Factory App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(), // Use Google Fonts Lato
      ),
      home: MyHomePage(title: 'Factory App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  int _selectedFactory = 1; // Default to Factory 1

  // Data for Factory 1
  List<Employee> factory1Employees = [];
  Map<String, dynamic> factory1Data = {
    'steamPressure': 100,
    'steamFlow': 20,
    'waterLevel': 50,
    'powerFrequency': 60,
  };
  Map<String, dynamic> factory1Thresholds = {
    'steamPressure': 90,
    'steamFlow': 15,
    'waterLevel': 40,
    'powerFrequency': 55,
  };

  // Data for Factory 2
  List<Employee> factory2Employees = [];
  Map<String, dynamic> factory2Data = {
    'steamPressure': 120,
    'steamFlow': 25,
    'waterLevel': 60,
    'powerFrequency': 58,
  };
  Map<String, dynamic> factory2Thresholds = {
    'steamPressure': 110,
    'steamFlow': 20,
    'waterLevel': 50,
    'powerFrequency': 50,
  };

  // Function to add an employee
  void _addEmployee(int factoryId, String name, String phoneNumber) {
    if (factoryId == 1) {
      setState(() {
        factory1Employees.add(Employee(name: name, phoneNumber: phoneNumber));
      });
    } else if (factoryId == 2) {
      setState(() {
        factory2Employees.add(Employee(name: name, phoneNumber: phoneNumber));
      });
    }
  }

  // Function to switch between factories
  void _switchFactory(int factoryId) {
    setState(() {
      _selectedFactory = factoryId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.title, style: GoogleFonts.lato()), // Apply Google Font
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          ProfilePage(
            factoryId: _selectedFactory,
            employees: _selectedFactory == 1
                ? factory1Employees
                : factory2Employees,
            onAddEmployee: (name, phoneNumber) =>
                _addEmployee(_selectedFactory, name, phoneNumber),
          ),
          HomePage(
            factoryId: _selectedFactory,
            data: _selectedFactory == 1
                ? factory1Data
                : factory2Data,
            thresholds: _selectedFactory == 1
                ? factory1Thresholds
                : factory2Thresholds,
          ),
          SettingsPage(
            factoryId: _selectedFactory,
            data: _selectedFactory == 1
                ? factory1Thresholds
                : factory2Thresholds,
            onDataChanged: (key, value) {
              if (_selectedFactory == 1) {
                setState(() {
                  factory1Thresholds[key] = value;
                });
              } else if (_selectedFactory == 2) {
                setState(() {
                  factory2Thresholds[key] = value;
                });
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _switchFactory(1);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.factory),
                          SizedBox(height: 15.0),
                          Text('Factory 1', style: GoogleFonts.lato()),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _switchFactory(2);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.factory),
                          SizedBox(height: 15.0),
                          Text('Factory 2', style: GoogleFonts.lato()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blueAccent,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            showSelectedLabels: false,
            // Hide selected labels
            showUnselectedLabels: false, // Hide unselected labels
          ),
        ],
      ),
    );
  }
}

// Employee Class
class Employee {
  final String name;
  final String phoneNumber;

  Employee({required this.name, required this.phoneNumber});
}

// Profile Page
class ProfilePage extends StatefulWidget {
  final int factoryId;
  final List<Employee> employees;
  final Function(String, String) onAddEmployee;

  const ProfilePage({
    Key? key,
    required this.factoryId,
    required this.employees,
    required this.onAddEmployee,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Controller for Name TextField
  final _nameController = TextEditingController();

  // Controller for Phone Number TextField
  final _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Factory ${widget.factoryId} Employees',
            style: GoogleFonts.lato(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: widget.employees.length,
              itemBuilder: (context, index) {
                final employee = widget.employees[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(employee.name, style: GoogleFonts.lato()),
                    subtitle: Text(employee.phoneNumber, style: GoogleFonts.lato()),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16.0),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Add Employee', style: GoogleFonts.lato()),
                        content: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(labelText: 'Name', labelStyle: GoogleFonts.lato()),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a name';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _phoneNumberController,
                                decoration: InputDecoration(labelText: 'Phone Number', labelStyle: GoogleFonts.lato()),
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a phone number';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel', style: GoogleFonts.lato(color: Colors.redAccent)),
                          ),
                          TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                widget.onAddEmployee(
                                    _nameController.text, _phoneNumberController.text);
                                Navigator.of(context).pop();
                                _nameController.clear();
                                _phoneNumberController.clear();
                              }
                            },
                            child: Text('Add', style: GoogleFonts.lato(color: Colors.green)),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  ),
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  final int factoryId;
  final Map<String, dynamic> data;
  final Map<String, dynamic> thresholds;

  const HomePage({
    Key? key,
    required this.factoryId,
    required this.data,
    required this.thresholds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Factory $factoryId Status', style: GoogleFonts.lato()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '1549.7kW',
                style: GoogleFonts.lato(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomGauge(
                  title: 'Steam Pressure',
                  value: data['steamPressure'].toDouble(),
                  unit: 'bar',
                  maxValue: thresholds['steamPressure'].toDouble(),
                ),
                CustomGauge(
                  title: 'Steam Flow',
                  value: data['steamFlow'].toDouble(),
                  unit: 'T/H',
                  maxValue: thresholds['steamFlow'].toDouble(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomGauge(
                  title: 'Water Level',
                  value: data['waterLevel'].toDouble(),
                  unit: '%',
                  maxValue: thresholds['waterLevel'].toDouble(),
                ),
                CustomGauge(
                  title: 'Power Frequency',
                  value: data['powerFrequency'].toDouble(),
                  unit: 'Hz',
                  maxValue: thresholds['powerFrequency'].toDouble(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '2024-04-26 13:45:25',
                style: GoogleFonts.lato(fontSize: 16.0, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTile(String title, dynamic value, dynamic threshold) {
    Color color = value >= threshold ? Colors.green : Colors.red;
    return Card(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.lato(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '$value',
              style: GoogleFonts.lato(fontSize: 20, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

// Settings Page
class SettingsPage extends StatefulWidget {
  final int factoryId;
  final Map<String, dynamic> data;
  final Function(String, dynamic) onDataChanged;

  const SettingsPage({
    Key? key,
    required this.factoryId,
    required this.data,
    required this.onDataChanged,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Controllers for TextFields
  final _steamPressureController = TextEditingController();
  final _steamFlowController = TextEditingController();
  final _waterLevelController = TextEditingController();
  final _powerFrequencyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _steamPressureController.text = widget.data['steamPressure'].toString();
    _steamFlowController.text = widget.data['steamFlow'].toString();
    _waterLevelController.text = widget.data['waterLevel'].toString();
    _powerFrequencyController.text = widget.data['powerFrequency'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Factory ${widget.factoryId} Settings', style: GoogleFonts.lato()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  _buildSettingTile(
                    'Steam Pressure',
                    _steamPressureController,
                        (value) => widget.onDataChanged('steamPressure', value),
                  ),
                  _buildSettingTile(
                    'Steam Flow',
                    _steamFlowController,
                        (value) => widget.onDataChanged('steamFlow', value),
                  ),
                  _buildSettingTile(
                    'Water Level',
                    _waterLevelController,
                        (value) => widget.onDataChanged('waterLevel', value),
                  ),
                  _buildSettingTile(
                    'Power Frequency',
                    _powerFrequencyController,
                        (value) => widget.onDataChanged('powerFrequency', value),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile(
      String title,
      TextEditingController controller,
      Function(dynamic) onChanged) {
    return ListTile(
      title: Text(title, style: GoogleFonts.lato()),
      trailing: SizedBox(
        width: 80,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            onChanged(double.tryParse(value) ?? 0.0);
          },
          style: GoogleFonts.lato(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _steamPressureController.dispose();
    _steamFlowController.dispose();
    _waterLevelController.dispose();
    _powerFrequencyController.dispose();
    super.dispose();
  }
}
