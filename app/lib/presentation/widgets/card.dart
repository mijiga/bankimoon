import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/cubit/accounts_cubit.dart';

class AccountCard2 extends StatelessWidget {
  const AccountCard2({
    super.key,
    required this.accountId,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.isFavourite,
  });

  final int accountId;
  final String accountName;
  final String accountNumber;
  final String bankName;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            color: Colors.white,
            child: SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 20,
                  ),
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          accountName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          accountNumber,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          bankName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      right: 20.0,
                    ),
                    child: SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              BlocProvider.of<AccountsCubit>(context)
                                  .markAsFavourite(accountId);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Added to favourites"),
                                ),
                              );
                            },
                            child: Icon(Icons.favorite,
                                color: isFavourite
                                    ? Colors.red[400]
                                    : Colors.deepPurple),
                          ),
                          const InkWell(
                            //Todo: Add a dropdown menu
                            //? Options: Remove as favourite
                            //?        : Delete
                            //?        : Edit

                            child: Icon(
                              Icons.more_vert,
                              size: 30,
                              color: Colors.blueAccent,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(
                        text: accountNumber,
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Copied to clipboard"),
                      ),
                    );
                  },
                  child: const Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: SizedBox(
                      height: 35,
                      width: 180,
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.copy,
                                    color: Colors.blueAccent,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Copy",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Share.share(
                      "$bankName \nName: $accountName \nAccount Number: $accountNumber \n \nShared from Bankimoon App",
                    );
                  },
                  child: const Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: SizedBox(
                      height: 35,
                      width: 180,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.share,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Share",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
