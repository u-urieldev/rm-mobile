import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/app_user.dart';

class AuthProvider extends ChangeNotifier {
  /*
    Este provider se encarga de guardar los datos del usuario y estos pueden usarse 
    en cualquier punto de la app
  */

  //Variables de para uso firebase
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Variables de estado
  AppUser? currentUser;

  Future<String> createUser(String email, String password, String name) async {
    try {
      // registrar un usuario y luego guardar datos importantes en un documento del usuario
      //CollectionReference users = _instance.collection("users");
      String? uid;

      UserCredential credential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: email.toLowerCase(), password: password);

      uid = credential.user!.uid;

      //Crear objeto de usuario
      currentUser = AppUser(
          name: name,
          uid: uid,
          email: email,
          cards: [],
          friends: [],
          requests: [],
          profile_image: "");

      notifyListeners();

      CollectionReference users = _instance.collection("users");
      await users.doc(uid).set(currentUser!.toMap());

      //Agrregar datos adicionales a la coleccion de users
      //await users.add({"email": email.toLowerCase(), "type": "customer", "uid": uid});

      return "exito";
    } on FirebaseAuthException catch (e) {
      //Regresar mensaje de error
      switch (e.code) {
        case "invalid-email":
          return "Formato de correo incorrecto";
        case "weak-password":
          return "La contraseña debe tener 6 o mas caracteres";

        case "email-already-in-use":
          return "El correo ya se encuentra registrado ";

        case "operation-not-allowed":
          return "Error al crear cuenta, favor de intentar mas tarde";
      }
    }
    return "fail";
  }

  Future<String> login(String email, String password) async {
    try {
      //Referencia a coleccion en db
      CollectionReference users = _instance.collection("users");
      String? uid;

      UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: email.toLowerCase(), password: password);
      uid = credential.user!.uid;

      //Buscar los datos del usuario en su coleccion
      DocumentSnapshot snapshot = await users.doc(uid).get();

      if (snapshot.exists) {
        // Keep the user data in the user variable
        final userData = snapshot.data() as Map<String, dynamic>;

        currentUser = AppUser.fromMap(userData);

        //Actualizar estado de app
        notifyListeners();
        print(currentUser!.profile_image);
        return "exito";
      }

      return "Error, no se encontraron datos del usuario";
    } on FirebaseAuthException catch (e) {
      //Regresar mensaje de error
      switch (e.code) {
        case "invalid-email":
          return "Formato de correo incorrecto";

        case "wrong-password":
          return "La contraseña es incorrecta";

        case "user-not-found":
          return "Cuenta no registrada";

        case "user-disabled":
          return "Cuenta temporalmente deshabilitada";
      }
    }

    return "Error inesperado";
  }
}
