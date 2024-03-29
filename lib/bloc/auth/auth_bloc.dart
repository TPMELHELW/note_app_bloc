import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:note_app_bloc/core/errors/auth_error.dart';
import 'package:note_app_bloc/core/repo/auth_repository.dart';
import 'package:note_app_bloc/view/widgets/custom_dialog.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;
  AuthBloc({required this.authRepository})
      : super(const AuthStateLoggedOut(isLoading: false)) {
    //log in action
    on<AuthEventLogIn>(
      (event, emit) async {
        emit(const AuthStateLoggedOut(isLoading: true));
        if (event.formState.currentState!.validate()) {
          try {
            final credential = await authRepository.logIn(
              event.email,
              event.passowrd,
            );

            if (credential is UserCredential) {
              print('success');
              return emit(
                  AuthStateLoggedIn(isLoading: false, user: credential.user!));
            } else if (credential is FirebaseAuthException) {
              print('success1');
              emit(
                AuthStateLoggedOut(
                  isLoading: false,
                  authError: AuthError.from(credential),
                ),
              );
            }
          } on FirebaseAuthException catch (e) {
            print('success2');
            emit(
              AuthStateLoggedOut(
                isLoading: false,
                authError: AuthError.from(e),
              ),
            );
          }
        }
        emit(
          const AuthStateLoggedOut(
            isLoading: false,
          ),
        );
      },
    );
    //sign up action
    on<AuthEventSignUp>(
      (event, emit) async {
        if (event.formState.currentState!.validate()) {
          emit(
            const AuthStateIsInRegistrationView(
              isLoading: true,
            ),
          );
          final credential = await authRepository.signUp(
            event.email,
            event.password,
            event.firstName,
            event.lastName,
          );

          try {
            if (credential is UserCredential) {
              customDialog(
                event.context,
                DialogType.success,
                "Success",
                "Please check your Email",
                "OK",
                () {},
              );
              return emit(
                const AuthStateLoggedOut(
                  isLoading: false,
                ),
              );
            } else if (credential is FirebaseAuthException) {
              return emit(
                AuthStateIsInRegistrationView(
                  isLoading: false,
                  authError: AuthError.from(credential),
                ),
              );
            }
          } catch (e) {
            return emit(
              AuthStateIsInRegistrationView(
                isLoading: false,
                authError: AuthError.from(credential),
              ),
            );
          }
        } else {
          return emit(
            const AuthStateIsInRegistrationView(
              isLoading: false,
            ),
          );
        }
      },
    );

    //sign out action
    on<AuthEventLogOut>(
      (event, emit) async {
        emit(
          const AuthStateLoggedOut(
            isLoading: true,
          ),
        );
        await FirebaseAuth.instance.signOut();
        return emit(
          const AuthStateLoggedOut(
            isLoading: false,
          ),
        );
      },
    );
    on<AuthEventGoToLogIn>(
      (event, emit) {
        emit(
          const AuthStateLoggedOut(
            isLoading: false,
          ),
        );
      },
    );
    on<AuthEventGoToSignUp>(
      (event, emit) {
        emit(
          const AuthStateIsInRegistrationView(
            isLoading: false,
          ),
        );
      },
    );
    on<AuthEventInitialize>((event, emit) {});
    on<AuthEventFieldChange>((event, emit) {});
  }
}
