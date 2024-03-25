Instruction:
# add scrollable_table_view: ^2.0.3 in pubspec.yaml file
# add the library of the package package:scrollable_table_view/src/scrollable_table_view.dart in the desired file
# write the headers of the table in the headers attribute
# to set rows in the table dynamically store all the data in a list from api or firebase then access that list into the rows attribute
# it has a cell where you can set your desired value from a list passed
# Enjoy both side scrollable table


ScrollableTableView(
              headers: [
                "S.no",
                "Order Date",
                "Order ID",
                "Order Code",
                "Android Apps",
                "IOS Apps",
                "Blue Devices",
                "Ship Address",
                "Total Cost"
              ].map((label) {
                return TableViewHeader(
                  label: label,
                );
              }).toList(),
              rows: order.map((order) {
                // this i varaible was used for S.no no need to use this 
                i++;
                return TableViewRow(
                  height: 60,
                  cells: [
                    TableViewCell(child: Text("${i}")),
                    TableViewCell(child: Text(order.code)),
                    TableViewCell(child: Text(order.code)),
                    TableViewCell(child: Text(order.code)),
                    TableViewCell(child: Text(order.android.toString())),
                    TableViewCell(child: Text(order.ios.toString())),
                    TableViewCell(child: Text(order.devices.toString())),
                    TableViewCell(child: Text(order.shippingAddress.address)),
                    TableViewCell(child: Text(order.payment.amount.toString())),
                  ],
                );
              }).toList(),
            ),
          
