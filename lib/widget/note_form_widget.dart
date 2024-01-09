import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final String? category;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedCategory;

  const NoteFormWidget({
    Key? key,
    this.isImportant = false,
    this.number = 0,
    this.title = '',
    this.description = '',
    this.category = '',
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Switch(
                    value: isImportant ?? false,
                    onChanged: onChangedImportant,
                  ),
                  Expanded(
                    child: Slider(
                      value: (number ?? 0).toDouble(),
                      min: 0,
                      max: 5,
                      divisions: 5,
                      onChanged: (number) => onChangedNumber(number.toInt()),
                    ),
                  )
                ],
              ),
              SizedBox(height: 8),
              buildTitle(),
              SizedBox(height: 8),
              buildCategoryDropdown(),
              SizedBox(height: 8),
              buildDescription(),
              SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildCategoryDropdown() {
    final categories = ['Casa', 'Oficina', 'Familia', 'Otros'];
    final selectedCategory =
        categories.contains(category) ? category : categories[0];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categoría',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(179, 0, 0, 0),
            ),
          ),
          SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedCategory,
            items: categories
                .map((category) => DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    ))
                .toList(),
            onChanged: (value) => onChangedCategory(value!),
          ),
        ],
      ),
    );
  }

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: TextStyle(
          color: const Color.fromARGB(179, 0, 0, 0),
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Título',
          hintStyle: TextStyle(color: Color.fromARGB(179, 165, 164, 164)),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'El título no debe estar vacío'
            : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        style:
            TextStyle(color: const Color.fromARGB(153, 0, 0, 0), fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Descripción de la nota...',
          hintStyle: TextStyle(color: const Color.fromARGB(179, 165, 164, 164)),
        ),
        validator: (description) => description != null && description.isEmpty
            ? 'La descripción no puede estar vacía'
            : null,
        onChanged: onChangedDescription,
      );
}
