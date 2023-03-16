import 'package:brainwired_interview/home_screen/controller/home_screen_provider.dart';
import 'package:brainwired_interview/home_screen/model/user_model.dart';
import 'package:brainwired_interview/utils/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

/// This screen is for showing the home screen
/// and it is showing the data coming from the API.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //The variable to find the size of device.
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Chat',
            style: GoogleFonts.raleway(
              fontSize: 30,
            ),
          ),
          backgroundColor: ConstantColors().constantOrangeColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(45),
            ),
          ),
        ),
      ),
      // Future builder for calling the API to get
      // the users data.
      body: FutureBuilder(
        future: Provider.of<HomeScreenProvider>(context, listen: false)
            .getUsersData(),
        builder: (context, AsyncSnapshot snapshot) {
          // Condition to check status of the API call,
          // and if the API calling is working in current
          // situation then a circular progress indicator
          // will show in the screen.
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // Condition to check status of the API call,
          // and if the API calling has an error
          // then a error text will be show in the screen.
          if (snapshot.hasError) {
            return const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            );
          }
          final List<User> users = snapshot.data;
          return ListView.separated(
            itemCount: users.length,
            itemBuilder: (context, index) {
              // Container to show the users details.
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: size.height * 0.15,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: ConstantColors().constantOrangeColor,
                      radius: 40,
                      child: Text(
                        users[index].id.toString(),
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          users[index].name.toString(),
                          style: GoogleFonts.urbanist(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          users[index].email.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
          );
        },
      ),
    );
  }
}
