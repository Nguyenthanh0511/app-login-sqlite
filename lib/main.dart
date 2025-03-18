import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguyen_trung_thanh/login_bloc.dart';
import 'package:nguyen_trung_thanh/login_state.dart';
import 'package:nguyen_trung_thanh/login_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login app',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const LogginPage(), // Page để logging
    );
  }
}

class LogginPage extends StatefulWidget{
  const LogginPage({super.key});
   @override
  _LogginPageState createState() => _LogginPageState();
}
// ... existing code ...

class _LogginPageState extends State<LogginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đăng nhập thành công!')),
              );
            }
            if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error!)),
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // CCawn chỉnh giữa
                    children: [
                      const Text(
                        'Đăng nhập',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Tên đăng nhập',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (username) {
                          context.read<LoginBloc>().add(
                            LoginUsernameChanged(username), // Thêm vàoo khối logic
                          );
                        },
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Vui lòng nhập tên đăng nhập';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Mật khẩu',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        onChanged: (password) {
                          context.read<LoginBloc>().add(
                            LoginPasswordChanged(password),
                          );
                        },
                        validator: (value) { ///--------------------------Kiểm tra xem có giá trị nhập vào
                          if (value?.isEmpty ?? true) {
                            return 'Vui lòng nhập mật khẩu';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.blue),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: ElevatedButton( //-----------------Lấy dữ liệu ( Tại thời điểm đăng nhập )
                          onPressed: state.isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    context.read<LoginBloc>().add( /// Thêm vào khối nghiệp vụ
                                      LoginSubmitted(
                                        username: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                                  }
                                },
                          child: state.isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Đăng nhập'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


//////// Code cũ
  /*
  return Scaffold(

   
    body: Align(
      // padding: const EdgeInsets.all(15),
      alignment: Alignment.center,
      child: Form(
        key: _formKey,
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.center, 
          children: <Widget>[
             Text(
              'Đăng nhập',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Xin vui lòng nhập email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email không được để trống';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Email không hợp lệ';
                }
                return null;
              },
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Xin vui lòng nhập password',
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password không được để trống';
                }
                if (value.length < 6) {
                  return 'Mật khẩu phải có ít nhất 6 ký tự';
                }
                return null;
              },
            ),
            const SizedBox(height: 24.0),
             Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.blue), // tạo border viền ngoài
                borderRadius: BorderRadius.circular(30.0), // tạo hình tròn
              ),
            child: ElevatedButton(
              onPressed: _loggin,
              child: const Text('Đăng nhập'),
            )),
          ],
        ),
      ),
    ),
  );
  */