import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:question_it/questions/question.dart';

class QuestionsRepository {


  static final String _questionCollection = "sessions";
  static final String _questionIdentifier = "id";

  Question _activeQuestion;
  get activeQuestion => _activeQuestion;

  final Map<String, Question> allQuestions = HashMap();

  CollectionReference _getCollection() {
    return Firestore
        .instance
        .collection(_questionCollection);
  }

  Future<Question> _create(Question question) async {
    var collection = _getCollection();
    await collection
        .add(question.toJson());

    var result = await collection.where("id", isEqualTo: question.id).getDocuments();

    return Question.fromJson(result.documents.first.data);
  }

  Future<DocumentSnapshot> _fetchDocument(Question question) async {
    var results = await _getCollection()
        .where(_questionIdentifier, isEqualTo: question.id)
        .getDocuments();
    var documents = results.documents;

    if(documents.length == 0)
      return null;

    return documents.first;
  }

  Future<Question> _fetchExisting(Question question) async {
    var document = await _fetchDocument(question);
    if(document == null)
        return null;
    return Question.fromJson(document.data);

  }

  Future<Question> create(Question question) async {
    var existing = await _fetchExisting(question);
    if(existing != null) {
      return existing;
    }
    return _activeQuestion = await _create(question);
  }

  Future<Question> get(String id) {
    return _fetchExisting(Question(id: id));
  }

  Future<Question> update(Question question) async {
    var existing = await _fetchDocument(question);
    await _getCollection().document("${existing.documentID}").updateData(question.toJson());
    return _activeQuestion = question;
  }
}

class QuestionDoesNotExist {
  final String questionId;
  QuestionDoesNotExist(this.questionId);
}