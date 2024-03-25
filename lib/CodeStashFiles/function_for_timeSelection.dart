Future<void> _selectTime(BuildContext context, int a) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xffCD9403),

            //accentColor: const Color(0xffCD9403),
            colorScheme: const ColorScheme.light(primary: Color(0xffCD9403)),
            buttonTheme: ButtonTheme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                secondary: Colors
                    .cyan, // Color you want for action buttons (CANCEL and OK)
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    
    
  }