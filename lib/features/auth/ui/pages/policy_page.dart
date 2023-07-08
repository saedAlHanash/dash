import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_dash/core/widgets/my_button.dart';
import 'package:qareeb_dash/core/widgets/my_text_form_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../bloc/create_policy_cubit/policy_cubit.dart';
import '../../bloc/policy_cubit/create_policy_cubit.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    var policy = '';
    return Scaffold(
      body: BlocListener<CreatePolicyCubit, CreatePolicyInitial>(
        listenWhen: (p, c) => c.statuses.done,
        listener: (context, state) {
          context.read<PolicyCubit>().getPolicy(context);
        },
        child: BlocBuilder<PolicyCubit, PolicyInitial>(builder: (_, state) {
          if (state.statuses.loading) {
            return MyStyle.loadingWidget();
          }
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyEditTextWidget(
                  initialValue: state.result.policy,
                  onChanged: (p0) => policy = p0,
                  maxLines: 20,
                  innerPadding: const EdgeInsets.all(20.0).r,
                ),
                BlocBuilder<CreatePolicyCubit, CreatePolicyInitial>(
                  builder: (context, state) {
                    if (state.statuses.loading) {
                      return MyStyle.loadingWidget();
                    }
                    return MyButton(
                      onTap: () async {
                        context
                            .read<CreatePolicyCubit>()
                            .createPolicy(context, policy: policy);
                      },
                      text: 'تحديث',
                    );
                  },
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
