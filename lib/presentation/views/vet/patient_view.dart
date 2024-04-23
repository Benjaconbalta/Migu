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
    final sizepatient = ref.watch(sizePatientsProvider);
    final filterText = ref.watch(filterTextProvider);

    TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Color(0xff3D9A51),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Acción al presionar el botón
                },
                child: const Text("Crear Paciente"),
              ),
            ),
            SizedBox(
              height: 30,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Pacientes",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text("$sizepatient")
                ],
              ),
            ),
            SizedBox(
              width: 500,
              height: 500,
              child: tutors.when(
                data: (data) {
                  final filteredTutors = data.where((tutor) => tutor.namePet
                      .toLowerCase()
                      .contains(filterText.toLowerCase()));
                  return ListView.builder(
                    itemCount: filteredTutors.length,
                    itemBuilder: (context, index) {
                      final tutor = filteredTutors.elementAt(index);
                      return ListTile(
                        subtitle: Text(
                          "Tutor: ${tutor.namePet}",
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
                          tutor.namePet,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward_ios_sharp,
                          ),
                        ),
                      );
                    },
                  );
                },
                error: (error, stackTrace) {
                  print(error);
                  return Text("Error: ${error.toString()}");
                },
                loading: () {
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
