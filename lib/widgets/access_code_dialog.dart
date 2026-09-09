import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/courses/presentation/viewmodels/access_code_cubit/access_code_cubit.dart';
import '../features/courses/presentation/viewmodels/access_code_cubit/access_code_state.dart';
import 'access_code_components/access_code_header.dart';
import 'access_code_components/access_code_input_field.dart';
import 'access_code_components/access_code_action_buttons.dart';

class AccessCodeDialog extends StatefulWidget {
  final int? folderId;
  final VoidCallback? onSuccess;

  const AccessCodeDialog({super.key, this.folderId, this.onSuccess});

  @override
  State<AccessCodeDialog> createState() => _AccessCodeDialogState();
}

class _AccessCodeDialogState extends State<AccessCodeDialog> {
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccessCodeCubit, AccessCodeState>(
      listener: (context, state) {
        if (state is AccessCodeSuccess) {
          Navigator.pop(context); // Close dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: const [
                  Icon(Icons.check_circle, color: Colors.white, size: 24),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Access granted! Folder unlocked.',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.green.shade600,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
              elevation: 8,
              duration: const Duration(seconds: 3),
            ),
          );
          if (widget.onSuccess != null) {
            widget.onSuccess!();
          }
        }
      },
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AccessCodeHeader(),
              const SizedBox(height: 28),

              // Premium Text Field
              AccessCodeInputField(controller: _codeController),
              const SizedBox(height: 16),

              // Error Message
              BlocBuilder<AccessCodeCubit, AccessCodeState>(
                builder: (context, state) {
                  if (state is AccessCodeError) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        state.message,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return const SizedBox(height: 16);
                },
              ),

              // Buttons
              AccessCodeActionButtons(
                controller: _codeController,
                folderId: widget.folderId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
