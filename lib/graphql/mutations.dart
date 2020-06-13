import 'package:flutter/material.dart';

class MutationBackend {

  static String createTour(String token, String name, String description, int difficulty, String id) {
    //var d = t.descr.text;
    //var dif = t.difficulty;
    //var name = t.name.text;
    //var id = name.substring(0, 4) + difficulty.toString();
    print("SEARCHID: $id");
    return """mutation{
      createTour(description: "$description", difficulty: $difficulty, name: "$name", searchId: "$id", sessionId: 0, token: "$token"){
        tour {
          id
          name
          status
        }
        ok {... on StringField{string}}
      }
    }""";
  }

  static String createObjectCheckpoint(String token, String objectId, String tourId, bool showDetails, bool showPictures, bool showText) {
    return """mutation{
      createObjectCheckpoint(objectId: "$objectId", showDetails: $showDetails, showPicture: $showPictures, showText: $showText, text: "", token: "$token", tourId: "$tourId"){
        ok {... on BooleanField{boolean}}
        checkpoint {
          id
          text
        }
      }
    }""";
  }

  static String createTextExtra(String token, String text, String tourId) {
    return """mutation{
      createCheckpoint(text: "$text", token: "$token", tourId: "$tourId"){
        checkpoint {
          id
        }
        ok {... on BooleanField{boolean}}
      }
    }""";
  }

  static String createImageExtra(String token, String tourId, String img) {
    return """mutation{
      createPictureCheckpoint(pictureId: "$img", text: "", token: "$token", tourId: "$tourId"){
        checkpoint {
          id
        }
        ok {... on BooleanField{boolean}}
      }
    }""";
  }

  static String createTextTask(String token, String stopId, String tourId, String question, String labels) {
    return """mutation{
      createQuestion(linkedObjects: ["$stopId"], 
      questionText: "$question", 
      showDetails: false, showPicture: false, showText: false,
      text: "$labels",
      token: "$token",
      tourId: "$tourId"){
        question{
          id
          index
        }
        ok {... on BooleanField{boolean}}
      }
    }""";
  }

  static String createMCTask(String token, String objectId, String tourId, String corrAnsw, int maxChoices, String labels, String question) {
    return """mutation{
      createMcQuestion(correctAnswers: $corrAnsw, linkedObjects: ["$objectId"], maxChoices: $maxChoices, possibleAnswers: $labels, questionText: "$question", showDetails: false, showPicture: false, showText: false, token: "$token", tourId: "$tourId"){
        question {
          id
          index
        }
        ok {... on BooleanField{boolean}}
      }
    }""";
  }

  static String joinTour(String token, String tourId) {
    return """mutation{
      addMember(sessionId: 0, token: "$token", tourId: "$tourId"){
        ok {... on BooleanField{boolean}}
        tour {
          id
          name
        }
      }
    }""";
  }

  static String auth(String password, String username) {
    return '''mutation{
      auth(password: "$password", username: "$username"){
        accessToken
        refreshToken
        ok
      }
    }''';
  }

  static String refresh(String rToken) {
    return """mutation{
      refresh(refreshToken: "$rToken"){
        newToken
      } 
    }""";
  }

  static String createUser(String password, String username) {
    return """mutation{
      createUser(password: "$password", username: "$username"){
        user{
          username
          password
        }
        ok
      }
    }""";
  }

  static String changePassword(String token, String password) {
    return """mutation{
      changePassword(password: "$password", token: "$token"){
        ok { ... on BooleanField{boolean}}
      }
    }""";
  }

  static String changeUsername(String token, String username) {
    return """mutation{
      changeUsername(token: "$token", username: "$username"){
        ok { ... on BooleanField{boolean}}
        user {
          username
          password
        }
        refreshToken
      }
    }""";
  }

  static String chooseProfilePicture(String id, String token) {
    return """mutation{
      chooseProfilePicture(pictureId: "$id", token: "$token"){
        ok { ... on BooleanField{boolean}}
      }
    }""";
  }

  static String fileUpload(Image file) {
    return r"""
      mutation{
  fileUpload(file:$file ){
    success
  }
}
    """;
  }

  static String addFavTour(String token, String tourId) {
    return """mutation{
      addFavouriteTour(token: "$token", tourId: "$tourId"){
        ok {... on BooleanField{boolean}}
      }
    }""";
  }

  static String removeFavTour(String token, String tourId) {
    return """mutation{
      removeFavouriteTour(token: "$token", tourId: "$tourId"){
        ok {... on BooleanField{boolean}}
      }
    }""";
  }

  static String addFavStop(String token, String stopId) {
    return """mutation{
      addFavouriteObject(token: "$token", objectId: "$stopId"){
        ok {... on BooleanField{boolean}}
      }
    }""";
  }

  static String removeFavStop(String token, String stopId) {
    return """mutation{
      removeFavouriteObject(token: "$token", objectId: "$stopId"){
        ok {... on BooleanField{boolean}}
      }
    }""";
  }

  static String promote(String token, String code) {
    return """mutation{
      promoteUser(token: "$token", code: "$code"){
        user {
          producer
        }
        ok {... on BooleanField{boolean}}
      }
    }""";
  }

  static String uploadAnswer(String token, String answer, String questionID) {
    return """mutation{
      createAnswer(answer: "$answer", questionId: "$questionID", token: "$token"){
        answer{
          id
        }
        ok {... on BooleanField{boolean}}
      }
    }""";
  }

  static String uploadMCAnswer(String token, List<int> answer, String questionId) {
    return """mutation{
      createMcAnswer(answer: """+ answer.toString() +""", questionId: "$questionId", token: "$token"){
        answer{
          id
        }
        ok {... on  BooleanField{boolean}}
      }
    }""";
  }

  static String deleteCheckpoint(String token, String id) {
    return """mutation{
      deleteCheckpoint(checkpointId: "$id", token: "$token"){
        ok {... on BooleanField{boolean}}
      }
    }""";
  }
}
