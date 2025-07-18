import 'package:flutter/material.dart';

class CostsTab extends StatelessWidget {
  const CostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Costs', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
              'Detailed information about tuition, fees, and living expenses will be here.',
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }
}
