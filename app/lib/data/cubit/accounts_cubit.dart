import 'package:bankimoon/data/isar_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'accounts_state.dart';

class AccountsCubit extends Cubit<AccountsState> {
  IsarRepo repository = IsarRepo.instance;

  AccountsCubit() : super(AccountsInitial());

  //fetch user accounts
  void getUserAccounts() {
    emit(FetchingAccounts());
    repository.getAccounts().then((value) {
      emit(
        AccountsFetched(accounts: value),
      );
    }).catchError((err) {
      emit(AccountFetchError(message: 'Got error $err'));
    });
  }

  // Fetch favourite accounts from the store
  void favouriteAccounts() {
    emit(FetchingAccounts());
    repository.getFavourites().then((value) {
      emit(
        AccountsFetched(accounts: value),
      );
    }).catchError((err) {
      emit(AccountFetchError(message: 'Got error $err'));
    });
  }

  // add account
  void addAccount(institutionName, accountName, accountNumber) {
    emit(SubmittingAccount());
    repository
        .addAccount(institutionName, accountName, accountNumber)
        .then((value) {
      emit(
        AccountSubmitted(
          msg: 'Account saved',
        ),
      );
    });
  }

  // Search account
  void searchAccount(String query) {
    repository.searchAccount(query).then((value) {
      emit(AccountSearchResults(accounts: value));
    }).catchError((err) {
      emit(AccountFetchError(message: 'Got error $err'));
    });
  }

  void searchFavouriteAccounts(String query) {
    repository.searchFavouriteAccounts(query).then((value) {
      emit(AccountSearchResults(accounts: value));
    }).catchError((err) {
      emit(AccountFetchError(message: 'Got error $err'));
    });
  }

  Future<void> markAsFavourite(int accountId) async {
    await repository.markAsFavourite(accountId);

    repository.getAccounts().then((value) {
      emit(AccountsFetched(accounts: value));
    });
  }

  // delete account
  Future<void> deleteAccount(int id) async {
    await repository.deleteAccount(id);

    repository.getAccounts().then((value) {
      emit(AccountsFetched(accounts: value));
    });
  }

  // nuke all accounts from db
  void nukeAccounts() {
    emit(DeletingAccounts());
    repository.deleteAccounts().then((value) => {
          emit(
            AccountsDeleted(
              msg: 'Accounts deleted',
            ),
          )
        });
  }

  // Migrate data from the SQLite to Isar
  Future migrateData() async {
    await repository.migrateData();
  }
}
