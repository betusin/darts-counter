import 'package:dartboard/pages/local_game_page.dart';
import 'package:dartboard/widgets/redirect_game_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/app_bar/custom_app_bar.dart';

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
      appBar: CustomAppBar(
        title: Text('New Local Game'),
        context: context,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  Column(
                    children: [],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: _buildGameModeDropdown(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: _buildPlayersDropdown(),
                  ),
                  ..._buildPlayerCards(),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                      onPressed: () {
                        final pageToPush = MaterialPageRoute(
                          builder: (BuildContext context) {
                            return LocalGamePage(
                                numberOfPlayers: playerNumberValue,
                                names:
                                    playerNames.sublist(0, playerNumberValue),
                                startingScore: int.parse(gameModeValue));
                          },
                        );
                        Navigator.push(context, pageToPush);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('Start game'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          if (FirebaseAuth.instance.currentUser != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: RedirectGameButton(
                location: '/game/online/start',
                text_game_mode: 'online',
              ),
            ),
        ],
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
            Text(
              'GAME MODE:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
                value: gameModeValue,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
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
        ));
  }

  Widget _buildPlayersDropdown() {
    return Container(
        height: 80,
        color: Colors.blue[100],
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'No. PLAYERS:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            DropdownButton<int>(
                value: playerNumberValue,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                items:
                    playerNumberOptions.map<DropdownMenuItem<int>>((int value) {
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
        ));
  }

  List<Widget> _buildPlayerCards() {
    List<Widget> nameSetters = [];
    for (int i = 0; i < playerNumberValue; i++) {
      nameSetters.add(Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: _buildNameSetter(i),
      ));
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
              Text('Player ${index + 1} name:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
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
        ));
  }
}
