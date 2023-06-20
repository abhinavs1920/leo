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
      getStartedPageTitle: (doc.data() as dynamic)['getStartedPageTitle'] ??
          'Leo District 325 I, Nepal',
      getStartedPageLeoLogo: (doc.data() as dynamic)['getStartedPageLeoLogo'] ??
          'https://firebasestorage.googleapis.com/v0/b/leo-nepal.appspot.com/o/appImages%2Fleo_logo.png?alt=media&token=02948583-f50e-4698-ab84-664728ceff83',
      getStartedPageDistrictLogo: (doc.data()
              as dynamic)['getStartedPageDistrictLogo'] ??
          'https://firebasestorage.googleapis.com/v0/b/leo-nepal.appspot.com/o/appImages%2Fdistrict_logo.png?alt=media&token=6d8d6b65-7287-4586-aab7-531385dcaf93',
      getStartedPageMessages:
          (doc.data() as dynamic)['getStartedPageMessages'] ?? [],
      getStartedPageBtnText:
          (doc.data() as dynamic)['getStartedPageBtnText'] ?? '',
      getStartedPageFooterText:
          (doc.data() as dynamic)['getStartedPageFooterText'] ?? '',
    );
  }

  Stream<Object?> get csmData {
    return _csmdataCollection
        .doc('MOBCUs4RFHc07EuQWFZv')
        .snapshots()
        .map(_csmDataFromDocument);
  }

  Future<CSMData> getCSMData() async {
    DocumentSnapshot doc =
        await _csmdataCollection.doc('MOBCUs4RFHc07EuQWFZv').get();
    return _csmDataFromDocument(doc);
  }
}
