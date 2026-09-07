import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/presentation/viewmodels/auth_cubit.dart';
import '../viewmodels/edit_profile_cubit.dart';
import '../widgets/edit_profile_body.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          EditProfileCubit(authCubit: context.read<AuthCubit>())
            ..initFromAuthState(context.read<AuthCubit>().state),
      child: const EditProfileBody(),
    );
  }
}
