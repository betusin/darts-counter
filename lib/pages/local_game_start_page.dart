import 'package:dartboard/pages/local_game_page.dart';
import 'package:flutter/material.dart';

/*
page where ppl will set the names, number of players and starting score
TODO fix support for multiple players
 */
class LocalGameStart extends StatefulWidget {
  const LocalGameStart({super.key});

  @override
  State<LocalGameStart> createState() => _LocalGameStartState();
}

class _LocalGameStartState extends State<LocalGameStart> {
  final player1NameController = TextEditingController();
  final player2NameController = TextEditingController();
  final List<String> gameModes = ['301', '501', '701'];
  String gameModeValue = '501';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Local Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildScoreSetter(),
            _buildNameSetter(),
            _buildNameSetter(),
            Spacer(),
            SizedBox(
              width: 200,
              height: 80,
              child: ElevatedButton(
                  onPressed: (){
                    final pageToPush = MaterialPageRoute(
                      builder: (BuildContext context) {
                        return LocalGamePage(numberOfPlayers: 2, names: ['PLAYER1','pl2x'], startingScore: int.parse(gameModeValue));
                      },
                    );
                    Navigator.push(context, pageToPush);
                  },
                  child: Text("Start")),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  Widget _buildNameSetter() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        height: 100,
        color: Colors.blue[100],
        alignment: Alignment.center,
        child: Text('playername')
      ),
    );
  }

  Widget _buildScoreSetter() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
          height: 80,
          color: Colors.blue[100],
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('GAME MODE:'),
              DropdownButton<String>(
                  value: gameModeValue,
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
      ),
    );
  }
  
}
