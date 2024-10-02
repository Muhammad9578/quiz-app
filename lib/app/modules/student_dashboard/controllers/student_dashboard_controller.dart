import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app_flutter/app/modules/student_dashboard/views/student_home_page.dart';
import 'package:quiz_app_flutter/app/utils/extensions.dart';

class StudentDashboardController extends GetxController {
  Rx<DocumentSnapshot?> selectedFolder = Rx<DocumentSnapshot?>(null);
  FirebaseAuth auth = FirebaseAuth.instance;
  RxList<dynamic> questions = [].obs;
  final Rx<TextEditingController> updatename =
      Rx<TextEditingController>(TextEditingController());
  PageController pageController = PageController();

  Rx<Map<String, dynamic>?> userData =
      Rx<Map<String, dynamic>?>(<String, dynamic>{});
  RxInt wronganswers = 0.obs;
  RxInt selectedSetIndex = 0.obs;

  RxInt selectedOption = 4.obs;
  RxInt selectedTab = 0.obs;
  List pages = [const StudentHomePage(), const StudentHomePage()];
  changeTab(int index) {
    selectedTab.value = index;
  }

  moveToNext() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);
  }

  @override
  void onReady() {
    super.onReady();
    getStudentData();
  }

  getStudentData() async {
    DocumentReference userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    DocumentSnapshot userSnap = await userRef.get();
    if (userSnap.exists) {
      userData.value = userSnap.data() as Map<String, dynamic>?;
      updatename.value.text = userData.value!["name"];
      userData.refresh();
    }
  }

  showcorrectAnswerDialog(var question, bool canmovenext) async {
    await Get.dialog(
      WillPopScope(
        onWillPop: () {
          if (canmovenext == true) {
            moveToNext();
          } else {
            showresultDialog();
          }

          return Future.value(true);
        },
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.green,
                    padding: const EdgeInsets.all(8.0),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Correct ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '😊',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.SpaceX,
                        Text(
                          '${question["question"]}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        10.SpaceX,
                        const Text(
                          'Goes with:',
                          style: TextStyle(fontSize: 13),
                        ),
                        10.SpaceX,
                        Text(
                          question["option"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        20.SpaceX,
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.back();
                              if (canmovenext == true) {
                                moveToNext();
                              } else {
                                showresultDialog();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(8.0),
                            ),
                            child: const Text('Continue'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  showwrongAnswerDialog(
      var question, bool canmovenext, String choosenanswer) async {
    await Get.dialog(
      WillPopScope(
        onWillPop: () {
          if (canmovenext == true) {
            moveToNext();
          } else {
            showresultDialog();
          }

          return Future.value(true);
        },
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          '😕',
                          style: TextStyle(fontSize: 18),
                        ),
                        5.SpaceY,
                        const Text(
                          'Study this one! ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.SpaceX,
                        Text(
                          '${question["question"]}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        10.SpaceX,
                        const Text(
                          'Correct answer:',
                          style: TextStyle(fontSize: 13, color: Colors.green),
                        ),
                        10.SpaceX,
                        Text(
                          question["option"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        5.SpaceX,
                        const Divider(
                          thickness: 2,
                          color: Colors.black,
                        ),
                        5.SpaceX,
                        const Text(
                          'You said:',
                          style: TextStyle(fontSize: 13, color: Colors.red),
                        ),
                        10.SpaceX,
                        Text(
                          choosenanswer,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        20.SpaceX,
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.back();
                              if (canmovenext == true) {
                                moveToNext();
                              } else {
                                showresultDialog();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(8.0),
                            ),
                            child: const Text('Continue'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  showresultDialog() async {
    int length = selectedFolder
        .value!["sets"][selectedSetIndex.value]['questions'].length;
    await Get.dialog(
        WillPopScope(
          onWillPop: () {
            addScoreToFirestore();
            Get.back();
            Get.back();
            return Future.value(true);
          },
          child: AlertDialog(
            title: const Text(''),
            contentPadding: const EdgeInsets.all(12),
            titlePadding: EdgeInsets.zero,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 60,
                    child: Image.asset("assets/images/resultcard.png")),
                const Text(
                  'Result Card',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                15.SpaceX,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Questions:"),
                    Text(length.toString()),
                  ],
                ),
                5.SpaceX,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Correct Answers:"),
                    Text((length - wronganswers.value).toString()),
                  ],
                ),
                5.SpaceX,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Wrong Answers:"),
                    Text((wronganswers.value).toString()),
                  ],
                ),
              ],
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    addScoreToFirestore();
                    Get.back();
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                  ),
                  child: const Text('Finish'),
                ),
              ),
            ],
          ),
        ),
        barrierDismissible: false);
  }

  void addScoreToFirestore() {
    int totalQuestions = selectedFolder
        .value!["sets"][selectedSetIndex.value]['questions'].length;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference scoreBoard = firestore.collection('scoreBoard');
    Map<String, dynamic> data = {
      'studentid': auth.currentUser!.uid ?? "",
      'teacherid': selectedFolder.value!["createdby"],
      'totalQuestions': totalQuestions.toString(),
      'correctAnswers': (totalQuestions - wronganswers.value).toString(),
      'wrongAnswers': (wronganswers.value).toString(),
      'folderName': selectedFolder.value!["folderName"],
      "performedby": userData.value!["name"],
      'setName':
          selectedFolder.value!["sets"][selectedSetIndex.value]["setName"] ?? ""
    };
    scoreBoard
        .add(data)
        .then((value) => print('Data added successfully with id: ${value.id}'))
        .catchError((error) => print('Failed to add data: $error'));
  }
}
