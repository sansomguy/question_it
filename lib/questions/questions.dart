import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:question_it/questions/question.dart';
import 'package:rxdart/rxdart.dart';

class QuestionsRepository {

  static final String _questionCollection = "sessions";
  static final String _questionIdentifier = "id";

  BehaviorSubject<Question> _activeQuestion;
  Stream<Question> get activeQuestion => _activeQuestion;

  QuestionsRepository() {
    _activeQuestion = BehaviorSubject<Question>();
  }

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
    var createdQuestion = await _create(question);
    _activeQuestion.add(createdQuestion);
    return createdQuestion;
  }

  Future<Question> update(Question question) async {
    var existing = await _fetchDocument(question);
    await _getCollection().document("${existing.documentID}").updateData(question.toJson());
    _activeQuestion.add(question);
    return question;
  }
}

class QuestionDoesNotExist {
  final String questionId;
  QuestionDoesNotExist(this.questionId);
}