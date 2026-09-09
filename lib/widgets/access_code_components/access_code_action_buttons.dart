import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../../features/courses/presentation/viewmodels/access_code_cubit/access_code_cubit.dart';
import '../../features/courses/presentation/viewmodels/access_code_cubit/access_code_state.dart';

class AccessCodeActionButtons extends StatelessWidget {
  final TextEditingController controller;
  final int? folderId;

  const AccessCodeActionButtons({
    super.key,
    required this.controller,
    required this.folderId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessCodeCubit, AccessCodeState>(
      builder: (context, state) {
        final isLoading = state is AccessCodeLoading;
        return Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: TextButton(
                  onPressed: isLoading ? null : () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.primaryCyan,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryCyan.withValues(alpha: 0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          if (folderId != null) {
                            context.read<AccessCodeCubit>().validateCode(
                              folderId!,
                              controller.text.trim(),
                            );
                          } else {
                            Navigator.pop(context);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text(
                          'Unlock',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
