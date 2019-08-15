import 'package:basic_app/pages/VehicleServices.dart';
import 'package:basic_app/pages/SettingsPage.dart';
import 'package:basic_app/pages/VehicleInformationPage.dart';
import 'package:flutter/material.dart';

class VehicleMainPage extends StatefulWidget{
  VehicleMainPage({Key key}) : super (key: key);

  @override
  _VehicleMainPageState createState() => _VehicleMainPageState();
}
class _VehicleMainPageState extends State<VehicleMainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Car App"),
      ),
      body: _buildBody(context),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), title: Text("Vehicle Information")),
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), title: Text("Vehicle History")),
          BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text("Settings"))
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(onPressed: _addNewItem(_selectedIndex),),
          );
        }
      
        Widget _buildBody(BuildContext context) {
          if(_selectedIndex == 0){
            return VehicleInformationPage();
          }
          else if (_selectedIndex == 1){
            return VehicleServices();
          }
          else{
            return SettingsPage();
          }
        }
      
        _onItemTapped(int index){
          setState(() {
            _selectedIndex = index; 
          });
        }
      
        _addNewItem(int selectedIndex) {
          if(selectedIndex == 0){
            
          }
          else{

          }
        }
}
