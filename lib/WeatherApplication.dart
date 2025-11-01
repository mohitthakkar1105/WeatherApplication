import 'package:flutter/material.dart';
import 'package:learn1/MyInFoFile.dart';
import 'dart:ui';
import 'package:learn1/WeatherForcast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityname = 'Indore';
      //Future<dynamic>
      var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityname&APPID=4d38e7a6eba7297c8b8fe990f72ae9b4',
      );

      var result = await http.get(url);
      var data = jsonDecode(result.body);
      if (data["cod"] == "200") {
        return data;
      } else {
        throw data["message"];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: const Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            ); //if ios then cupertiono me adjust if adroid then material me adjust
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            // var D;
            // if (snapshot.data != null) {
            //   D = snapshot.data;
            // }
            // or
            var data = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Card(
                      elevation: 20,
                      color: Colors.white10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          16,
                        ), //andar ke content ka bhi corner round ho jayega
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 10,
                            sigmaY: 10,
                          ), //dart:ui ka import karna padega
                          child: Column(
                            children: [
                              SizedBox(height: 16),
                              Text(
                                "${data["list"][0]["main"]["temp"]} k",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              Icon(
                                (data["list"][0]["weather"][0]["main"]) ==
                                            'Clouds' ||
                                        (data["list"][0]["weather"][0]["main"]) ==
                                            'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 80,
                              ),
                              SizedBox(height: 16),
                              Text(
                                "${data["list"][0]["weather"][0]["main"]}",
                                style: TextStyle(fontSize: 30),
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Weather Forecast",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       for (int i = 1; i < 5; i++)
                  //         HourlyUpdate(
                  //           time:
                  //               "${data["list"][i]["dt_txt"].substring(11, 16)}",
                  //           icon:
                  //               data["list"][i]["weather"][0]["main"] ==
                  //                       'Clouds' ||
                  //                   data["list"][i]["weather"][0]["main"] ==
                  //                       'Rain'
                  //               ? Icons.cloud
                  //               : Icons.sunny,
                  //           temp: "${data["list"][i]["main"]["temp"]} k",
                  //         ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, i) {
                        return HourlyUpdate(
                          time:
                              "${data["list"][i + 1]["dt_txt"].substring(11, 16)}",
                          icon:
                              data["list"][i + 1]["weather"][0]["main"] ==
                                      'Clouds' ||
                                  data["list"][i + 1]["weather"][0]["main"] ==
                                      'Rain'
                              ? Icons.cloud
                              : Icons.sunny,
                          temp: "${data["list"][i + 1]["main"]["temp"]} k",
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Additional Information",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MyInfo(
                          icon: Icons.water_drop_sharp,
                          label: "Humidity",
                          value: "${data["list"][0]["main"]["humidity"]}",
                        ),
                        MyInfo(
                          icon: Icons.air,
                          label: "Wind Speed",
                          value: "${data["list"][0]["wind"]["speed"]}",
                        ),
                        MyInfo(
                          icon: Icons.beach_access,
                          label: "pressure",
                          value: "${data["list"][0]["main"]["pressure"]}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

// 1]gestureDector or inkwell dono hi clickable widget banate hain
// 2]GestureDetector is more generic and can be used for any widget, while InkWell is specifically designed for Material Design widgets and provides visual feedback on tap.
// 3]InkWell provides a ripple effect when tapped, which is a visual feedback that indicates the tap action. GestureDetector does not provide any visual feedback by default.
// 4]InkWell requires a Material ancestor to work properly, while GestureDetector does not have this requirement.
// 5]iconButton bhi use kar sakte hai hum, lekin usme hum icon ka size aur color change kar sakte hain, lekin InkWell me hum koi bhi widget rakh sakte hain aur uske upar click kar sakte hain.
// 6]actions : AppBar ka ek property hota hai actions: jisme hum right side (top-right corner) me widgets (mostly buttons, icons) dete hain.

// Simple bolun to:

// leading: → Left side (generally back button ya drawer icon)

// title: → Center me (app ka title ya search bar)

// actions: → Right side (search, settings, more options, etc.)

// api :->
// ---------------

// import 'package:http/http.dart' as http;
// import 'dart:convert';

// Future<void> getWeatherData() async {
//   // 1️⃣ URL ko URI me convert karo
//   var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

//   // 2️⃣ Server se data manga (GET request)
//   var response = await http.get(url);

//   // 3️⃣ Check karo request successful thi ya nahi
//   if (response.statusCode == 200) {
//     // 4️⃣ Server ka data (JSON string) ko Dart Map me convert karo
//     var data = jsonDecode(response.body);
//     print("Title: ${data['title']}");
//   } else {
//     print("Request failed: ${response.statusCode}");
//   }
// }

// | Line                  | Kya karta hai                       | Example                    |
// | --------------------- | ----------------------------------- | -------------------------- |
// | `Uri.parse()`         | String URL ko Uri object banata hai | `Uri.parse('https://...')` |
// | `http.get(url)`       | Server se data manga                | API call                   |
// | `response.statusCode` | Status check karta hai              | `200 = OK`                 |
// | `response.body`       | Raw JSON data deta hai              | `"{'title':'Post 1'}"`     |
// | `jsonDecode()`        | JSON → Dart Map convert karta hai   | `{ 'title': 'Post 1' }`    |

// Jab data API ya database se thoda late aata hai (async), tab FutureBuilder use karte hain — ye wait karta hai aur jab data milta hai tab screen update kar deta hai.

// FutureBuilder(
//   future: getData(), // koi async function
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return CircularProgressIndicator(); // jab tak data nahi aaya
//     } else if (snapshot.hasError) {
//       return Text('Error: ${snapshot.error}');
//     } else {
//       return Text('Data: ${snapshot.data}'); // jab data mil gaya
//     }
//   },
// )

// Explanation of async/await and Future:
// Future return = promise
// Examples of Future return:
// API call
// Database se data fetch
// File read/write
// Delay (timer)
// Network request

// async = permission for await
// await = wait for future
// intl dependency = date/time formatting
