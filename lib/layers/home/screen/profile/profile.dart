import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_zybo/data/bloc/bloc_prfile/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileBloc profileBloc = ProfileBloc();
  @override
  void initState() {
    super.initState();
    profileBloc.add(ProfileFetchEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        
        centerTitle: false,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: profileBloc,
       
        builder: (context, state) {
          if(state is ProfileInitial){
            return Center(child: CircularProgressIndicator(),);
          }
          else if (state is ProfileDetailsFetched){
             return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Text(
                  "Name",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                Text(
                  state.profile.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  "Phone",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                Text(
                  "+91-${state.profile.phoneNumber}",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
          );
          }
          return Center(child: CircularProgressIndicator(),);
         
        },
      ),
    );
  }
}
