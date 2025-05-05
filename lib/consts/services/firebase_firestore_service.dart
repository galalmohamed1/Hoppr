// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:new_test_app/models/event_data_models.dart';
//
// abstract class FirebaseFireStoreService{
//   //[Function] to get collection reference
//   static CollectionReference<EventDataModel> getCollectionReference(){
//
//     return FirebaseFirestore.instance
//         .collection(EventDataModel.collectionName)
//         .withConverter<EventDataModel>(
//         fromFirestore: (snapshot, _) => EventDataModel.fromeFirestore(snapshot.data()!),
//         toFirestore: (data, _) => data.toFirestore(),
//     );
//   }
//
//   //[Function] to add a new event to the firestore
//   static Future<bool> createCard(EventDataModel data)async{
//     try{
//       var collectionRef=getCollectionReference();
//       var docRef= collectionRef.doc();
//       data.eventId=docRef.id;
//       docRef.set(data);
//       return Future.value(true);
//     }catch (error){
//       return Future.value(false);
//     }
//
//   }
//
//   //[Function] to getDataFormFirestore
//   static Future<List<EventDataModel>> getDataFormFirestore()async{
//     var collectionRef=getCollectionReference();
//     QuerySnapshot<EventDataModel> data= await collectionRef.get();
//     List<EventDataModel> eventDataList= data.docs.map((element) {
//       return element.data();
//     },).toList();
//     return eventDataList ;
//   }
//
//   //[Function] to deleteEvent
//   static Future<bool> deleteEvent(EventDataModel data){
//     try{
//       var collectionRef = getCollectionReference();
//       var docRef = collectionRef.doc(data.eventId);
//       docRef.delete();
//       return Future.value(true);
//     }catch (error){
//       return Future.value(false);
//     }
//   }
//
//   static Future<bool> updateEvent(EventDataModel data){
//     try{
//       var collectionRef = getCollectionReference();
//       var docRef = collectionRef.doc(data.eventId);
//       docRef.update(
//         data.toFirestore(),
//       );
//       return Future.value(true);
//     }catch (error){
//       return Future.value(false);
//     }
//   }
//   static Stream<QuerySnapshot<EventDataModel>> getStreamData(String categoryName) {
//     if(categoryName=="All"){
//       CollectionReference<EventDataModel> data=getCollectionReference();
//       return data.snapshots();
//     }
//
//     var collectionRef = getCollectionReference().where(
//       "eventCategory",
//       isEqualTo: categoryName,
//     );
//     return collectionRef.snapshots();
//   }
//   static Stream<QuerySnapshot<EventDataModel>> getStreamFavoriteData() {
//     var collectionRef = getCollectionReference().where(
//       "isFavorite",
//       isEqualTo: true,
//     );
//     return collectionRef.snapshots();
//   }
//
//
// }