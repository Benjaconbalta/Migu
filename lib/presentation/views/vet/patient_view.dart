import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:migu/presentation/delegates/search_profile_delegate.dart';
import 'package:migu/presentation/home/vet/intopatientScreen.dart';
import 'package:migu/presentation/providers/vets/vets_provider.dart';
import 'package:migu/widgets/shared/custom_text_form_field.dart';

final sizePatientsProvider = StateProvider<int>((ref) {
  return 56;
});
final filterTextProvider = StateProvider<String>((ref) => '');

class PatientView extends ConsumerWidget {
  const PatientView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tutors = ref.watch(vetFirebaseProvider);
    final filterText = ref.watch(filterTextProvider);

    TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              width: 290,
              height: 40,
              child: CustomTextFormField(
                onChanged: (value) {
                  ref
                      .read(filterTextProvider.notifier)
                      .update((state) => value);
                },
                label: "Beatriz",
                hint: "Buscar",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            tutors.when(
              data: (data) {
                final filteredTutors = data
                    .where((tutor) => tutor.name
                        .toLowerCase()
                        .contains(filterText.toLowerCase()))
                    .where((element) => element.role == true);
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Pacientes",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text("${filteredTutors.length}")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 900,
                      child: ListView.builder(
                        shrinkWrap: false,
                        itemCount: filteredTutors.length,
                        itemBuilder: (context, index) {
                          final tutor = filteredTutors.elementAt(index);
                      
                          return Column(
                            children: [
                               
                           if (index > 0 && index != filteredTutors.length - 1) // No añadir divisor para el primer ni último elemento
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 0.3,
                                  ),
                                ),
                              ListTile(
                                subtitle: Text(
                                  "tutor:${tutor.othername.isEmpty?"":tutor.name}",
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.w400),
                                ),
                                onTap: () {
                                  context.push("/IntopatientScreen");
                                  ref
                                      .read(uidUserProvider.notifier)
                                      .update((state) => tutor.uid);
                                },
                                leading: tutor.urlImage == ""
                                    ? tutor.type == "Perro"
                                        ? ClipOval(
                                            child: Image.asset(
                                              "assets/perro.png",
                                              width: 40,
                                            ),
                                          )
                                        : tutor.type == "otro"
                                            ? ClipOval(
                                                child: Image.asset(
                                                  "assets/conejo.png",
                                                  width: 40,
                                                ),
                                              )
                                            : ClipOval(
                                                child: Image.asset(
                                                  "assets/gato.png",
                                                  width: 40,
                                                ),
                                              )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(tutor.urlImage),
                                        radius: 18.0,
                                      ),
                                title: Text(
                                  "${ tutor.othername.isEmpty  ?  tutor.name:tutor.othername}",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_forward_ios_sharp),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
              error: (error, stackTrace) {
                return Text("Error: ${error.toString()}");
              },
              loading: () {
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
