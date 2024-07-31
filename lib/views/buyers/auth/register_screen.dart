// import 'package:flutter/material.dart';

// class RegisterScreen extends StatelessWidget {
//   const RegisterScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Create Customer Account',
//               style: TextStyle(
//                 fontSize: 20,
//               ),
//             ),
//             CircleAvatar(
//               radius: 64,
//               backgroundColor: Colors.yellow.shade900,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(13.0),
//               child: TextFormField(
//                 decoration: const InputDecoration(labelText: 'Enter Full Name'),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(13.0),
//               child: TextFormField(
//                 decoration:
//                     const InputDecoration(labelText: 'Enter Phone Number'),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(13.0),
//               child: TextFormField(
//                 decoration: const InputDecoration(labelText: 'Password'),
//               ),
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width - 40,
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.yellow.shade900,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: const Center(
//                 child: Text(
//                   'Register',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 19,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 4),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
