import 'package:flutter/material.dart';

void main() {
  runApp(BudgetTrackerApp());
}

class BudgetTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
        fontFamily: 'Roboto',
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(name: 'Groceries', iconData: Icons.shopping_cart),
    Category(name: 'Entertainment', iconData: Icons.movie),
    Category(name: 'Transportation', iconData: Icons.directions_car),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Budget Tracker')),
      body: Column(
        children: [
          UserInfoSection(),
          ExpenseTotalSection(),
          CategoryList(categories: categories),
        ],
      ),
    );
  }
}

class Category {
  final String name;
  final IconData iconData;

  Category({required this.name, required this.iconData});
}

class UserInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: CircleAvatar(
          radius: 50.0,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.person, size: 50.0, color: Colors.white),
        ),
      ),
    );
  }
}

class ExpenseTotalSection extends StatefulWidget {
  @override
  State<ExpenseTotalSection> createState() => _ExpenseTotalSectionState();
}

class _ExpenseTotalSectionState extends State<ExpenseTotalSection> {
  List<double> expenses = [50.0, 25.0, 15.0];

  double getTotalExpenses() {
    return expenses.reduce((value, element) => value + element);
  }

  @override
  Widget build(BuildContext context) {
    final totalExpenses = getTotalExpenses();

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Total Expenses',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Text(
            '\$${totalExpenses.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  final List<Category> categories;

  CategoryList({required this.categories});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            leading: Icon(category.iconData),
            title: Text(category.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExpenseScreen(category: category),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ExpenseScreen extends StatefulWidget {
  final Category category;

  ExpenseScreen({required this.category});

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  List<double> expenses = [50.0, 25.0, 15.0];

  void _addExpense(double amount) {
    setState(() {
      expenses.add(amount);
    });
  }

  double getTotalExpenses() {
    return expenses.reduce((value, element) => value + element);
  }

  @override
  Widget build(BuildContext context) {
    final totalExpenses = getTotalExpenses();

    return Scaffold(
      appBar: AppBar(title: Text('${widget.category.name} Expenses')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return ExpenseListItem(expense: expense);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddExpensePopup(onExpenseAdded: _addExpense);
                  },
                );
              },
              child: Text('Add Expense'),
            ),
          ),
          Text(
            'Total Expenses: \$${totalExpenses.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class ExpenseListItem extends StatelessWidget {
  final double expense;

  ExpenseListItem({required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade100,
      child: ListTile(
        title: Text('\$${expense.toStringAsFixed(2)}', style: TextStyle(fontSize: 18.0)),
      ),
    );
  }
}

class AddExpensePopup extends StatefulWidget {
  final Function(double) onExpenseAdded;

  AddExpensePopup({required this.onExpenseAdded});

  @override
  _AddExpensePopupState createState() => _AddExpensePopupState();
}

class _AddExpensePopupState extends State<AddExpensePopup> {
  double _amount = 0.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Expense'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _amount = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onExpenseAdded(_amount);
            Navigator.pop(context);
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
