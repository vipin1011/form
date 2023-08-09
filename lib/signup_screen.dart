

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/signup_bloc.dart';
import 'bloc/success_screen.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController(text: '');
  final TextEditingController lastNameController = TextEditingController(text: '');
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signup')),
      body: BlocProvider(
        create: (context) => SignupBloc(),
        child: BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            } else if (state.username.isNotEmpty) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessScreen(username:state.username,gender: state.gender,notification: state.receiveNotifications),),
              ).then((value) {
                firstNameController.clear();
                lastNameController.clear();
                context.read<SignupBloc>().add(ClearState());
              });
            }
          },
          child: BlocBuilder<SignupBloc, SignupState>(
            builder: (context, state) => Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                              labelText: 'First Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(color: Colors.grey)
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(color: Colors.black)
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null; // Input is valid
                          },
                        ),
                        SizedBox(height: 8.0,),
                        TextFormField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                              labelText: 'Last Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(color: Colors.grey)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(color: Colors.black)
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null; // Input is valid
                          },
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Gender', style: TextStyle(fontWeight: FontWeight.bold),),
                            Row(
                              children: [

                                Expanded(
                                  child: RadioListTile(
                                    title: Text('Male'),
                                    value: 'male',
                                    groupValue: context.read<SignupBloc>().state.gender,
                                    onChanged: (value) {
                                      if(value != null && value != '') {
                                        context.read<SignupBloc>().add(ToggleGender(gender: value));
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    title: Text('Female'),
                                    value: 'female',
                                    groupValue: context
                                        .read<SignupBloc>()
                                        .state
                                        .gender,
                                    onChanged: (value) {
                                      if(value != null && value != '') {
                                        context.read<SignupBloc>().add(ToggleGender(gender: value));
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),


                        SwitchListTile(
                          title: Text('Receive Notifications'),
                          value: context.read<SignupBloc>().state.receiveNotifications,
                          onChanged: (value) {
                            context.read<SignupBloc>().add(ToggleNotifications(receiveNotifications: value));
                          },
                        ),
                        CheckboxListTile(
                          title: Text('Accept Policy'),
                          value: context
                              .read<SignupBloc>()
                              .state
                              .acceptPolicy,
                          onChanged: (value) {
                            context.read<SignupBloc>().add(TogglePolicy(acceptPolicy: value!));
                          },
                        ),
                        MaterialButton(
                          onPressed: () {
                            if(context
                                .read<SignupBloc>()
                                .state
                                .acceptPolicy){
                              _formkey.currentState!.validate();
                              String firstName = firstNameController.text;
                              String lastName = lastNameController.text;
                              print(firstName + ' ' + lastName);
                              context.read<SignupBloc>().add(
                                FormSubmitted(
                                  firstName: firstName,
                                  lastName: lastName,
                                ),
                              );
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please tick - Accept Policy')));
                            }

                          },
                          child: Text('Signup'),
                          color: context.read<SignupBloc>().state.acceptPolicy
                              ? Colors.blue
                              : Colors.grey,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

