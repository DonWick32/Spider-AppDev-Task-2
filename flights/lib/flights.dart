import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class flights extends StatelessWidget {
  late List<FlightsData> data;
  late String ori;
  late String dest;

  flights(this.data,this.ori,this.dest);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            ori +":"+ dest,
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.home,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Color.fromARGB(255, 158, 146, 248),
                    child: ListTile(
                      leading: Container(
                        alignment: Alignment.center,
                        width: 60,
                        child: Text(
                          data[index].flightCode,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      title: Text(
                        data[index].airline,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: Text(
                        data[index].flight_date,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      trailing: Container(
                        width: 150,
                        child: Text(
                          "Departure : " + data[index].depTime +"\n"+
                          "Arrival : " + data[index].arrTime
                          ,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: data.length,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
