import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leo/models/csmdata.model.dart';

class CSMDataService {
  final CollectionReference _csmdataCollection =
      FirebaseFirestore.instance.collection('csmdata');

  CSMData _csmDataFromDocument(DocumentSnapshot doc) {
    return CSMData(
      regions: (doc.data() as dynamic)['regions'] ?? [],
      departments: (doc.data() as dynamic)['departments'] ?? [],
      organisers: (doc.data() as dynamic)['organisers'] ?? [],
    );
  }

  Stream<Object?> get csmData {
    return _csmdataCollection
        .doc('MOBCUs4RFHc07EuQWFZv')
        .snapshots()
        .map(_csmDataFromDocument);
  }

  Future<CSMData> getUserData() async {
    DocumentSnapshot doc =
        await _csmdataCollection.doc('MOBCUs4RFHc07EuQWFZv').get();
    return _csmDataFromDocument(doc);
  }
}
