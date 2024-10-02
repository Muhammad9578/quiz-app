import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quiz_app_flutter/app/modules/teacher_dashboard/views/folder_page.dart';
import 'package:quiz_app_flutter/app/utils/app_widgets.dart';

class TeacherDashboardController extends GetxController {
  ScrollController scrollController = ScrollController();
  // RxList<Widget> questionOptionWidgets = <Widget>[].obs;
  RxList<TextEditingController> questionOptionControllers =
      <TextEditingController>[].obs;
  RxList<FocusNode> questionOptionFocusNode = <FocusNode>[].obs;
  // LoginController loginController = Get.find();
  Rx<DocumentSnapshot?> selectedFolder = Rx<DocumentSnapshot?>(null);
  Rx<Map?> currentTeacher = Rx<Map?>(null);
  RxInt selectedSetIndex = 0.obs;
  RxInt selectedQuestionIndex = 0.obs;
  Rx<Map<String, dynamic>?> userData =
      Rx<Map<String, dynamic>?>(<String, dynamic>{});
  final Rx<TextEditingController> updatename =
      Rx<TextEditingController>(TextEditingController());
  final TextEditingController title = TextEditingController();
  final TextEditingController subtitle = TextEditingController();

  final TextEditingController settitle = TextEditingController();
  final TextEditingController setsubtitle = TextEditingController();

  // final TextEditingController question1 = TextEditingController();
  // final TextEditingController option1 = TextEditingController();
  // final TextEditingController question2 = TextEditingController();
  // final TextEditingController option2 = TextEditingController();
  // final TextEditingController question3 = TextEditingController();
  // final TextEditingController option3 = TextEditingController();

  RxInt selectedTab = 0.obs;
  List pages = [const FolderPage(), const FolderPage()];

  changeTab(int index) {
    selectedTab.value = index;
  }

  getTeacherData() async {
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

  @override
  void onInit() {
    super.onInit();
    fetchCurrentTeacher();
  }

  @override
  void onReady() {
    super.onReady();
    getTeacherData();
    questionOptionFocusNode.addAll([
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode()
    ]);
    questionOptionControllers.addAll([
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController()
    ]);
    // questionOptionWidgets.value.addAll([
    //   PrimaryTextField(
    //     ontap: () {},
    //     controller: questionOptionControllers[0],
    //     hinttext: 'Enter question',
    //     prefixIcon: Icons.title,
    //     focusnode: questionOptionFocusNode[0],
    //     onsubmit: (v) {
    //       questionOptionFocusNode[1].requestFocus();
    //     },
    //   ),
    //   PrimaryTextField(
    //     controller: questionOptionControllers[1],
    //     hinttext: 'Enter option',
    //     prefixIcon: CupertinoIcons.dot_square,
    //     focusnode: questionOptionFocusNode[1],
    //     onsubmit: (v) {
    //       questionOptionFocusNode[2].requestFocus();
    //     },
    //   ),
    //   PrimaryTextField(
    //     controller: questionOptionControllers[2],
    //     hinttext: 'Enter question',
    //     prefixIcon: Icons.title,
    //     focusnode: questionOptionFocusNode[2],
    //     onsubmit: (v) {
    //       questionOptionFocusNode[3].requestFocus();
    //     },
    //   ),
    //   PrimaryTextField(
    //     controller: questionOptionControllers[3],
    //     hinttext: 'Enter option',
    //     prefixIcon: CupertinoIcons.dot_square,
    //     focusnode: questionOptionFocusNode[3],
    //     onsubmit: (v) {
    //       questionOptionFocusNode[4].requestFocus();
    //     },
    //   ),
    //   PrimaryTextField(
    //     controller: questionOptionControllers[4],
    //     hinttext: 'Enter question',
    //     prefixIcon: Icons.title,
    //     focusnode: questionOptionFocusNode[4],
    //     onsubmit: (v) {
    //       questionOptionFocusNode[5].requestFocus();
    //     },
    //   ),
    //   PrimaryTextField(
    //     controller: questionOptionControllers[5],
    //     hinttext: 'Enter option',
    //     prefixIcon: CupertinoIcons.dot_square,
    //     focusnode: questionOptionFocusNode[5],
    //   )
    // ]);
  }

  Future<void> fetchCurrentTeacher() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      var data = documentSnapshot.data();
      currentTeacher.value = data as Map?;
      print('Data: $data');
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  createFolder() async {
    if (validateFields()) {
      try {
        Get.dialog(
            Loader(
              size: 50,
            ).visible(true),
            barrierDismissible: false);

        DocumentReference newCollectionRef =
            FirebaseFirestore.instance.collection('folders').doc();
        WriteBatch batch = FirebaseFirestore.instance.batch();
        List<Map<String, dynamic>> sets = [];

        batch.set(newCollectionRef, {
          'id': newCollectionRef.id,
          'creationdate': DateTime.timestamp(),
          'createdby': FirebaseAuth.instance.currentUser!.uid ?? "",
          'folderName': title.text,
          'teacherName': currentTeacher.value!['name'] ?? "NA",
          'folderSubtitle': subtitle.text,
          'sets': sets,
        });

        await batch.commit();
        clearController();
        Get.back();
        if (Get.isDialogOpen!) {
          Get.back();
        }
      } catch (e) {
        clearController();
        Get.back();
        if (Get.isDialogOpen!) {
          Get.back();
        }
        toast(e.toString());
      }
    }
  }

  deleteSet() async {
    Get.dialog(
        Loader(
          size: 50,
        ).visible(true),
        barrierDismissible: false);
    DocumentReference specificDocumentRef = FirebaseFirestore.instance
        .collection('folders')
        .doc(selectedFolder.value!["id"]);
    List newSets = [];

    newSets = selectedFolder.value!["sets"];
    newSets.removeAt(selectedSetIndex.value);
    await specificDocumentRef.update({
      'sets': newSets,
    }).then((_) async {
      toast('Set deleted successfully.');
      selectedFolder.value = await specificDocumentRef.get();
      selectedFolder.refresh();
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }).catchError((error) {
      if (Get.isDialogOpen!) {
        Get.back();
      }
      toast('Error adding set: $error');
    });
  }

  addSet() async {
    if (validateSetFields()) {
      try {
        Get.dialog(
            Loader(
              size: 50,
            ).visible(true),
            barrierDismissible: false);
        DocumentReference specificDocumentRef = FirebaseFirestore.instance
            .collection('folders')
            .doc(selectedFolder.value!["id"]);
        List newSets = [];
        List<Map<String, dynamic>> questions = [];
        newSets = selectedFolder.value!["sets"];

        newSets.add({
          'setName': settitle.text,
          'setSubtitle': setsubtitle.text,
          'questions': questions,
        });
        await specificDocumentRef.update({
          'sets': FieldValue.arrayUnion(newSets),
        }).then((_) async {
          toast('Set added successfully.');
          selectedFolder.value = await specificDocumentRef.get();
          selectedFolder.refresh();
        }).catchError((error) {
          toast('Error adding set: $error');
        });
        clearController();
        Get.back();
        if (Get.isDialogOpen!) {
          Get.back();
        }
      } catch (e) {
        clearController();
        Get.back();
        if (Get.isDialogOpen!) {
          Get.back();
        }
        toast(e.toString());
      }
    }
  }

  deleteQuestion() async {
    Get.dialog(
        Loader(
          size: 50,
        ).visible(true),
        barrierDismissible: false);
    DocumentReference specificDocumentRef = FirebaseFirestore.instance
        .collection('folders')
        .doc(selectedFolder.value!["id"]);
    List newQuestions = [];
    newQuestions =
        selectedFolder.value!["sets"][selectedSetIndex.value]['questions'];
    newQuestions.removeAt(selectedQuestionIndex.value);
    List sets = selectedFolder.value!["sets"];

    sets[selectedSetIndex.value]['questions'] = newQuestions;
    await specificDocumentRef.update({
      'sets': sets,
    }).then((_) async {
      toast('Questions deleted successfully.');
      selectedFolder.value = await specificDocumentRef.get();
      selectedFolder.refresh();
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }).catchError((error) {
      toast('Error deleting questions: $error');
      if (Get.isDialogOpen!) {
        Get.back();
      }
    });
  }

  addQuestion() async {
    print("enter");
    if (validateQuestionFields()) {
      print("enter1");
      try {
        print("enter2");
        Get.dialog(
            Loader(
              size: 50,
            ).visible(true),
            barrierDismissible: false);
        print("enter3");
        DocumentReference specificDocumentRef = FirebaseFirestore.instance
            .collection('folders')
            .doc(selectedFolder.value!["id"]);
        List newQuestions = [];
        print("enter4");
        newQuestions =
            selectedFolder.value!["sets"][selectedSetIndex.value]['questions'];
        for (int i = 0; i < questionOptionControllers.length; i++) {
          newQuestions.add({
            'question': questionOptionControllers[i].text,
            'option': questionOptionControllers[i + 1].text,
          });
          i++;
        }
        print("enter5");
        List sets = selectedFolder.value!["sets"];
        sets[selectedSetIndex.value]['questions'] = newQuestions;
        await specificDocumentRef.update({
          'sets': sets,
        }).then((_) async {
          toast('Questions added successfully.');
          selectedFolder.value = await specificDocumentRef.get();
          selectedFolder.refresh();
        }).catchError((error) {
          toast('Error adding questions: $error');
        });
        print("enter6");
        clearController();
        Get.back();
        if (Get.isDialogOpen!) {
          Get.back();
        }
      } catch (e) {
        clearController();
        Get.back();
        if (Get.isDialogOpen!) {
          Get.back();
        }
        toast(e.toString());
      }
    }
  }

  validateFields() {
    if (title.text.isEmpty) {
      toast("Please enter folder title");
      return false;
    }

    return true;
  }

  validateSetFields() {
    if (settitle.text.isEmpty) {
      toast("Please enter set title");
      return false;
    }

    return true;
  }

  validateQuestionFields() {
    for (int i = 0; i < questionOptionControllers.length; i++) {
      if (questionOptionControllers[i].text.isEmpty) {
        toast("Please fill all fields");
        return false;
      }
    }

    // if (questionOptionControllers[0].text.isEmpty) {
    //   toast("Please enter question1");
    //   return false;
    // } else if (questionOptionControllers[1].text.isEmpty) {
    //   toast("Please enter option1");
    //   return false;
    // } else if (questionOptionControllers[2].text.isEmpty) {
    //   toast("Please enter question2");
    //   return false;
    // } else if (questionOptionControllers[3].text.isEmpty) {
    //   toast("Please enter option2");
    //   return false;
    // } else if (questionOptionControllers[4].text.isEmpty) {
    //   toast("Please enter question3");
    //   return false;
    // } else if (questionOptionControllers[5].text.isEmpty) {
    //   toast("Please enter option3");
    //   return false;
    // }

    return true;
  }

  clearController() {
    title.clear();
    subtitle.clear();
    for (int i = 0; i < questionOptionControllers.length; i++) {
      questionOptionControllers[i].clear();
    }
    // option1.clear();
    // question1.clear();
    // question2.clear();
    // question3.clear();
    // option2.clear();
    // option3.clear();
    setsubtitle.clear();
    settitle.clear();
    questionOptionFocusNode = <FocusNode>[].obs;
    questionOptionControllers = <TextEditingController>[].obs;
    // questionOptionWidgets = <Widget>[].obs;

    questionOptionControllers.addAll([
      TextEditingController(),
      TextEditingController(),
    ]);
    questionOptionFocusNode.addAll([
      FocusNode(),
      FocusNode(),
    ]);
    // questionOptionWidgets.value.addAll([
    //   PrimaryTextField(
    //     controller: questionOptionControllers[0],
    //     hinttext: 'Enter question',
    //     prefixIcon: Icons.title,
    //     focusnode: questionOptionFocusNode[0],
    //     onsubmit: (v) {
    //       questionOptionFocusNode[1].requestFocus();
    //     },
    //   ),
    //   PrimaryTextField(
    //     controller: questionOptionControllers[1],
    //     hinttext: 'Enter option',
    //     prefixIcon: CupertinoIcons.dot_square,
    //     focusnode: questionOptionFocusNode[1],
    //   ),
    // ]);
  }
}
