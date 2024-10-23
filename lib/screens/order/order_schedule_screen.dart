// this is lib/screens/order/order_schedule_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/controllers/order_controller.dart';
import 'package:myapp/providers/cart_provider.dart';

class OrderScheduleScreen extends ConsumerStatefulWidget {
  const OrderScheduleScreen({super.key});

  @override
  _OrderScheduleScreenState createState() => _OrderScheduleScreenState();
}

class _OrderScheduleScreenState extends ConsumerState<OrderScheduleScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _scheduleOrder() async {
    if (_selectedDate != null && _selectedTime != null) {
      final scheduledDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );
      final cart = ref.read(cartProvider);
      await ref.read(orderControllerProvider.notifier).scheduleOrder(cart.items, scheduledDateTime);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Schedule Order')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Select Date'),
              trailing: _selectedDate == null
                  ? Icon(Icons.arrow_drop_down)
                  : Text(_selectedDate!.toString()),
              onTap: () => _selectDate(context),
            ),
            ListTile(
              title: Text('Select Time'),
              trailing: _selectedTime == null
                  ? Icon(Icons.arrow_drop_down)
                  : Text(_selectedTime!.format(context)),
              onTap: () => _selectTime(context),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scheduleOrder,
              child: Text('Schedule Order'),
            ),
          ],
        ),
      ),
    );
  }
}