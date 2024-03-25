# If you want to call async functions in initstate you need to add a functon which i have mentioned below


@override
  void initState() {
    // add this function and make it async now you can use any async function ther without getting any run time error
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await firebaseProvider.fetchOrdersDataOfBuyers();
    });
    super.initState();
  }
