import 'package:dartboard/pages/local_game_page.dart';
import 'package:flutter/material.dart';

/*
page where ppl will set the names, number of players and starting score
 */
class LocalGameStart extends StatefulWidget {
  const LocalGameStart({super.key});

  @override
  State<LocalGameStart> createState() => _LocalGameStartState();
}

class _LocalGameStartState extends State<LocalGameStart> {
  List<String> playerNames = ['Player1', 'Player2', 'Player3', 'Player4'];
  final List<String> gameModes = ['301', '501', '701'];
  String gameModeValue = '501';
  final List<int> playerNumberOptions = [2, 3, 4];
  int playerNumberValue = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Local Game'),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              _buildGameModeDropdown(),
              SizedBox(height: 6),
              _buildPlayersDropdown(),
              ... _buildPlayerCards(),
              SizedBox(height: 6),
              SizedBox(
                width: 200,
                height: 80,
                child: ElevatedButton(
                    onPressed: (){
                      final pageToPush = MaterialPageRoute(
                        builder: (BuildContext context) {
                          return LocalGamePage(numberOfPlayers: playerNumberValue, names: playerNames.sublist(0,playerNumberValue), startingScore: int.parse(gameModeValue));
                        },
                      );
                      Navigator.push(context, pageToPush);
                    },
                    child: Text("Start")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameModeDropdown() {
    return Container(
        height: 80,
        color: Colors.blue[100],
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('GAME MODE:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            DropdownButton<String>(
                value: gameModeValue,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                items: gameModes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    gameModeValue = value!;
                  });
                })
          ],
        )
    );
  }

  Widget _buildPlayersDropdown() {
    return Container(
        height: 80,
        color: Colors.blue[100],
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('No. PLAYERS:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            DropdownButton<int>(
                value: playerNumberValue,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                items: playerNumberOptions.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (int? value) {
                  setState(() {
                    playerNumberValue = value!;
                  });
                })
          ],
        )
    );
  }

  List<Widget> _buildPlayerCards() {
    List<Widget> nameSetters = [];
    for (int i = 0; i < playerNumberValue; i++) {
      nameSetters.add(SizedBox(height: 6));
      nameSetters.add(_buildNameSetter(i));
    }
    return nameSetters;
  }

  Widget _buildNameSetter(int index) {
    return Container(
        height: 50,
        color: Colors.blue[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Text('Player ${index+1} name:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 20),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: playerNames[index],
                  ),
                  onChanged: (value) {
                    setState(() {
                      playerNames[index] = value;
                    });
                  },
                ),
              ),
            ],
          ),
        )
    );
  }

  
}
