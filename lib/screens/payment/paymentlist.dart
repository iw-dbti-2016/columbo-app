import 'package:flutter/material.dart';

class PaymentList extends StatefulWidget {
  final List<Map<String, dynamic>> _payments;

  const PaymentList(this._payments);

  @override
  _PaymentListState createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            widget._payments[index]["isExpanded"] = !(widget._payments[index]
                        ["isExpanded"]
                    .toString()
                    .toLowerCase() ==
                "true");
          });
        },
        children: <ExpansionPanel>[
          for (var payment in widget._payments)
            ExpansionPanel(
              canTapOnHeader: true,
              isExpanded:
                  payment["isExpanded"].toString().toLowerCase() == "true",
              headerBuilder: (BuildContext context, bool bool) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              (payment["currency"] == "EUR")
                                  ? Icons.euro_symbol
                                  : Icons.attach_money,
                              color: Colors.black,
                              size: 25.0,
                            ),
                            Text(
                              payment["total_amount"].toString(),
                              style: const TextStyle(fontSize: 30.0),
                            ),
                          ],
                        ),
                        Text(
                          payment["date"].toString(),
                          style: TextStyle(
                              fontSize: 15.0, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            payment["name"].toString(),
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              "Payed by ${payment["payer"]["first_name"]} ${payment["payer"]["last_name"]} to ${payment["benificiary"]}",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              body: Column(
                children: <Widget>[
                  for (var payer in payment["payers"])
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  if (payer["payed"].toString().toLowerCase() ==
                                      "true")
                                    Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 36.0,
                                    ),
                                  if (payer["payed"].toString().toLowerCase() !=
                                      "true")
                                    Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 36.0,
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              (payment["currency"] == "EUR")
                                                  ? Icons.euro_symbol
                                                  : Icons.attach_money,
                                              size: 20.0,
                                            ),
                                            Text(
                                              payer["personal_amount"]
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 25.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${payer["user"]["first_name"]} ${payer["user"]["last_name"]}",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (payer["payed"].toString().toLowerCase() !=
                                  "true")
                                FlatButton(
                                  color: Colors.green,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      payer["payed"] = true;
                                    });
                                  },
                                  child: const Text("Pay"),
                                ),
                              if (payer["payed"].toString().toLowerCase() ==
                                  "true")
                                (payer["user"]["username"] ==
                                        payment["payer"]["username"])
                                    ? Container()
                                    : FlatButton(
                                        textColor: Colors.white,
                                        color: Colors.red,
                                        onPressed: () {
                                          setState(() {
                                            payer["payed"] = false;
                                          });
                                        },
                                        child: const Text("Revoke"),
                                      ),
                            ],
                          ),
                          if (payment["payers"].last == payer)
                            Container(
                              height: 36.0,
                              child: const Text(""),
                            ),
                          if (payment["payers"].last != payer) const Divider(),
                        ],
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
