import 'package:flutter/cupertino.dart';
import 'package:museum_app/database/moor_db.dart';

import '../constants.dart';
import 'graphqlConf.dart';

class QueryBackend {

  static String allObjects(String token) {
    return """query{
      allObjects(token: "$token"){
        additionalInformation
        artType
        category
        creator
        description
        interdisciplinaryContext
        location
        material
        objectId
        size_
        subCategory
        timeRange
        title
        year
        picture {
          id
        } 
      }
    } """;
  }

  static String tourSearchId(String token, String searchId) {
    return """query{
      tourSearchId(token: "$token", searchId: "$searchId")
    }""";
  }

  static String getTour(String token, String tourId) {
    return """query{
      tour(token: "$token", tourId: "$tourId"){
        creation
        currentCheckpoints
        description
        difficulty
        id
        name
        owner {
          username
        }
        searchId
        sessionId
        status
      }
    }""";
  }

  static String checkpointTour(String token, String tourId) {
    return """query{
      checkpointsTour(token: "$token", tourId: "$tourId"){
        ... on ObjectCheckpoint{
          index
          museumObject{
            objectId
          }
          showText
          showDetails
          showPicture
        }
        ... on Checkpoint{
          index
          text
        }
        ... on PictureCheckpoint{
          index
          id
          picture {
            id
          }
        }
        ... on Question{
          index
          text
          question
        }
        ... on MCQuestion{
          index
          question
          possibleAnswers
          correctAnswers
          maxChoices
        }
      }
    }""";
  }

  static String allPictures(String token) {
    return """ query{
      availableProfilePictures(token:"$token")
    } """;
  }

  static String userInfo(String token) {
    return """query{
      me(token: "$token"){
        id
        producer
        profilePicture {
          id
        }
        badgeProgress
        badges {
          id
          name
          cost
          description
        }
      }
    }""";
  }

  static String favTours(String token) {
    return """query{
      favouriteTours(token: "$token"){
        creation
        currentCheckpoints
        description
        difficulty
        id
        name
        owner {
          username
        }
        searchId
        sessionId
        status
      }
    }""";
  }

  static String profilePic(String token, String username) {
    return """query{
      profilePicture(token: "$token", username: "$username")
    }""";
  }

  static String favStops(String token) {
    return """query{
      favouriteObjects(token: "$token"){
        objectId
      }
    }""";
  }

  static String featured(String token) {
    return """query{
      featured(token: "$token"){
        creation
        description
        difficulty
        id
        name
        owner {
          username
        }
        searchId
        status
      }
    }""";
  }

  static created(String token) {
    return """query{
      ownedTours(token: "$token"){
        creation
        currentCheckpoints
        description
        difficulty
        id
        name
        owner {
          username
        }
        searchId
        sessionId
        status
      }
    }""";
  }

  static String allBadges(String token) {
    return """query{
      availableBadges(token: "$token"){
        cost
        description
        id
        name
      }
    }""";
  }

  static String availProfile(String token) {
    return """query{
      availableProfilePictures(token: "$token")
    }""";
  }

  static String questionId(String token, String tourId, int index) {
    return """query { 
      questionId(token: "$token", tourId: "$tourId", index: $index) 
    }""";
  }

  static String exportResult(String token, String tourId, String username) {
    return """query{
      exportAnswers(token: "$token", tourId: "$tourId", username: "$username")
    }""";
  }

  static String imageURLProfile(String id) {
    return imageURL("ProfilePicture", id);
  }

  static String imageURLBadge(String id) {
    return imageURL("Badge", id);
  }

  static String imageURLPicture(String id) {
    return imageURL("Picture", id);
  }

  static String imageURL(String type, String id) {
    return "$SERVER_ADDRESS/file/download?type=$type&id=$id";
  }

  static Widget netWorkImage(String url,
      {width = 50, height = 50, fit = BoxFit.cover}) {
    return FutureBuilder(
      future: MuseumDatabase().accessToken(),
      builder: (context, snap) {
        String token = snap.data ?? "";
        return FutureBuilder(
          future: GraphQLConfiguration.isConnected(token),
          builder: (context, snap) {
            bool connected = snap.hasData && snap.data;
            if (!connected || url.endsWith("&id="))
              return Container(
                width: width.toDouble(),
                height: height.toDouble(),
              );
            return Image.network(
              url,
              /*loadingBuilder: (context, b, c) => Image.asset(
                "assets/images/empty_profile.png",
                width: width.toDouble(),
                height: height.toDouble(),
              ),*/
              //GraphQLConfiguration().imageURLProfile("5e7e091dbef4a100e3735722"),
              headers: {"Authorization": "Bearer $token"},
              fit: fit,
              width: width.toDouble(),
              height: height.toDouble(),
            );
          },
        );
      },
    );
  }
}
