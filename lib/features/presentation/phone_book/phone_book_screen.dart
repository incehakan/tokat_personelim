import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../product/constants/app_dimensions.dart';
import '../../../product/constants/app_images.dart';
import '../../../product/constants/app_strings.dart';
import '../../../product/extensions/context_extensions.dart';
import '../../../product/utils/dependency_injection.dart';
import '../../data/models/phone_book_model.dart';
import '../../widgets/custom_error_text.dart';
import '../../widgets/loading_indicator.dart';
import 'cubit/phone_book_cubit.dart';

class PhoneBookScreen extends StatefulWidget {
  const PhoneBookScreen({Key? key}) : super(key: key);

  @override
  State<PhoneBookScreen> createState() => _PhoneBookScreenState();
}

class _PhoneBookScreenState extends State<PhoneBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.phoneBook),
      ),
      body: Padding(
        padding: AppDimensions.pagePadding,
        child: BlocProvider(
          create: (context) => getIt.get<PhoneBookCubit>()..getPhoneBooks(),
          child: BlocBuilder<PhoneBookCubit, PhoneBookState>(
            builder: (context, state) {
              if (state is PhoneBookFailed) {
                return Center(
                  child: CustomErrorText(message: state.message),
                );
              } else if (state is PhoneBookSuccess) {
                return ListView(
                  children: List.generate(
                    state.phones.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppDimensions.mediumGap,
                      ),
                      child: PhoneCard(
                        phone: state.phones[index],
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CustomLoadingIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class PhoneCard extends StatelessWidget {
  const PhoneCard({Key? key, required this.phone}) : super(key: key);

  final PhoneBook phone;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: context.height / 15,
                  height: context.height / 15,
                  margin: EdgeInsets.all(context.width / 30),
                  child: Image.asset(
                    AppImages.personImage,
                  ),
                  // color: Colors.blue,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${phone.adiSoyadi.toString()} (${phone.unvanAdi.toString()})',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      phone.calisilanBirim.toString(),
                    ),
                    Text(
                      "Dahili: ${phone.dahili!.round()}",
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.phone_enabled),
                color: Colors.green,
                onPressed: () {
                  _makePhoneCall("tel:0232293${phone.dahili!.round()}");
                },
              ),
              phone.cepTelefonu != null
                  ? IconButton(
                      icon: const Icon(Icons.phone_iphone_rounded),
                      color: Colors.green,
                      onPressed: () {
                        _makePhoneCall("tel:0${phone.cepTelefonu!}");
                      },
                    )
                  : Container()
            ],
          ),
        ],
      ),
    );
  }
}

Future<void> _makePhoneCall(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  }
}
