import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voca_grow_app/core/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:voca_grow_app/features/parent/child_management/child_management.dart';

class ChildForm extends StatefulWidget {
  final ChildModel? initialData;
  final Function(ChildModel child)? onSubmit;

  const ChildForm({super.key, this.onSubmit, this.initialData});

  @override
  State<ChildForm> createState() => _ChildFormState();
}

class _ChildFormState extends State<ChildForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  Gender? _selectedGender;
  bool _obscurePassword = true;
  DateTime? _selectedDate;
  List<Activity> _selectedActivities = [];

  @override
  void initState() {
    super.initState();
    final child = widget.initialData;
    _nameController = TextEditingController(
      text: child?.name ?? '',
    );
    _emailController = TextEditingController(
      text: child?.email ?? '',
    );
    _passwordController = TextEditingController(
      text: child?.password ?? '',
    );
    _selectedGender = child?.gender ?? Gender.male;
    _selectedDate = child?.birthDate ?? DateTime.now();
    _selectedActivities =
        child?.availableActivities ?? [Activity.speechTherapy];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: now,
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _toggleActivity(Activity activity) {
    setState(() {
      if (_selectedActivities.contains(activity)) {
        _selectedActivities.remove(activity);
      } else {
        _selectedActivities.add(activity);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChildBloc, ChildState>(
      listener: (context, state) {
        if (state is Susscess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sucessfully'),
              backgroundColor: Colors.green,
            ),
          );
        }

        if (state is ChildError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
            ),
          );
        }
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: 600),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),

                  const VerticalSpace(2),

                  // birth date
                  InkWell(
                    onTap: _pickDate,
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Birth Date',
                      ),
                      child: Text(
                        _selectedDate == null
                            ? 'Pick a date'
                            : DateFormat.yMMMMd().format(_selectedDate!),
                      ),
                    ),
                  ),

                  const VerticalSpace(2),

                  // gender
                  DropdownButtonFormField<Gender>(
                    value: _selectedGender,
                    hint: const Text("Select Gender"),
                    items:
                        Gender.values.map((g) {
                          return DropdownMenuItem(
                            value: g,
                            child: Text(g.name),
                          );
                        }).toList(),
                    onChanged: (val) => setState(() => _selectedGender = val),
                    validator: (val) => val == null ? 'Select gender' : null,
                  ),

                  const VerticalSpace(2),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Available Activities'),
                      const VerticalSpace(2),

                      Wrap(
                        spacing: 8,
                        children:
                            Activity.values.map((activity) {
                              return FilterChip(
                                label: Text(activity.name),
                                selected: _selectedActivities.contains(
                                  activity,
                                ),
                                onSelected: (_) => _toggleActivity(activity),
                              );
                            }).toList(),
                      ),
                    ],
                  ),

                  const VerticalSpace(2),

                  TextFormField(
                    controller: _emailController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    keyboardType: TextInputType.emailAddress,

                    decoration: InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const VerticalSpace(2),

                  TextFormField(
                    controller: _passwordController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                    ),
                    obscureText: _obscurePassword,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  const VerticalSpace(2),

                  BlocBuilder<ChildBloc, ChildState>(
                    builder: (context, state) {
                      return SubmitButtonWidget(
                        text:
                            widget.initialData == null
                                ? 'Add Child'
                                : 'Update Child',
                        isLoading: state is ChildLoading,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final child = ChildModel(
                              id:
                                  widget.initialData?.id ??
                                  _emailController.text.trim(),

                              name: _nameController.text.trim(),
                              gender: _selectedGender ?? Gender.male,
                              birthDate: _selectedDate ?? DateTime.now(),
                              availableActivities: _selectedActivities,
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                              parentEmail:
                                  context
                                      .read<ChildRepository>()
                                      .userParent
                                      .email,
                            );

                            await widget.onSubmit?.call(child);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
