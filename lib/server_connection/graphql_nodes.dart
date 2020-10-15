import 'dart:ui';

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
        lastEdit
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
          id
          index
          museumObject{
            objectId
          }
          showText
          showDetails
          showPicture
        }
        ... on Checkpoint{
          id
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
          id
          index
          text
          question
        }
        ... on MCQuestion{
          index
          id
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
        lastEdit
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
        lastEdit
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
        lastEdit
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

  static String myProfilePic(String token) {
    return """query{
      myProfilePictures(token: "$token")
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

  static String answersInTour(String token, String user, String tourId) {
    return """query{
      answersByUser(token: "$token", username: "$user", tourId: "$tourId") {
        ... on Answer {
          id
          question {
            index
            question
          }
          text: answer
        }
        ... on MCAnswer {
          id
          question {
            index
            question
          }
        answer
        }
      }
    }""";
  }

}

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

  static String createUser(String username, String password) {
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

  static String updateTourInfo(String token, String tourId, int diff, String name, String descr) {
    return """mutation{
      updateTour(description: "$descr", difficulty: $diff, name: "$name", token: "$token", tourId: "$tourId"){
        ok {... on BooleanField{boolean}}
      }
    }""";
  }

  static String deleteTour(String token, String tourId) {
    return """mutation{
      deleteTour(token: "$token", tourId: "$tourId"){
        ok {... on BooleanField{boolean}}
      }
    }""";
  }
}
